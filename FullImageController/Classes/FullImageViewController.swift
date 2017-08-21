//
//  FullImageViewController.swift
//  Pods
//
//  Created by Mingyoung on 2017/8/10.
//
//

import UIKit

let kFullImageScreenWidth = UIScreen.main.bounds.width
let kFullImageScreenHeight = UIScreen.main.bounds.height

public protocol FIPageControl:class {
    var selectIndex:Int{ set get }
    var numberOfIndex:Int { set get }
}

extension UIPageControl: FIPageControl {

    //MARK: FullImagePageControl
     public var numberOfIndex: Int {
        get {
            return self.numberOfPages
        }
        set {
            self.numberOfPages = newValue
        }
    }

     public var selectIndex: Int {
        get {
            return self.currentPage
        }
        set {
            self.currentPage = newValue
        }
    }
}

public enum FIPageControlType {
   case defaultControl //系统的pageControl
   case defined(FIPageControl) //自定义的pageControl
   case none //没有pageControl
}

/// 图片浏览器controller
public class FullImageViewController: UIViewController {
    
    public var imageArray:Array<FNFullImage>
    var reuseImageViewArray:Array<FullImageView> = []
    public var currentIndex:Int = 0 //默认值为0
    weak var scrollView:UIScrollView?
    public var currentImageView:FullImageView? //当前展示的imageView
    var pageControl:FIPageControl?
    //单次点击图片处理---默认是单次点击退出浏览模式
    public var singleTapFullImage:((_ fullImageView:FullImageView)->Void)?
    public var animations:BaseAnimatedTransitioning? {
        didSet {
            self.transitioningDelegate = animations
        }
    }
    
    
    //MARK: init
    required public init?<T:FNFullImage>(imageArray:Array<T>, currentIndex:Int,pageControlType:FIPageControlType){
        self.imageArray = imageArray
        self.currentIndex = currentIndex
        switch pageControlType {
        case .defaultControl:
        let pageControl = UIPageControl(frame: CGRect(x: 10, y: kFullImageScreenHeight - 50, width: 100, height: 30))
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor(colorLiteralRed: 51/255.0, green: 51/255.0 , blue: 51/255.0, alpha: 1.0)
        self.pageControl = pageControl
        case .defined(let pageControl):
        self.pageControl = pageControl
        case .none: break
        }
        super.init(nibName: nil, bundle: nil)
        initializationAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        initizalizeUI()
        prepareReuseImageViews()
        showImages()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: initizalize user interface
    private func initizalizeUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        let scrollView = UIScrollView(frame: self.view.bounds)
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.black
        
        let count = CGFloat(self.imageArray.count)
        let contentWidth = count * kFullImageScreenWidth
        scrollView.contentSize = CGSize(width: contentWidth, height: 0)
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * kFullImageScreenWidth, y: 0), animated: false)
       
        //单次点击图片事件
        self.singleTapFullImage = {
            [weak self] fullImageView in
            let fullAnimation = self?.animations as! FullImageAnimation
            fullAnimation.image = fullImageView.fullImageView?.image
            self?.dismiss(animated: true)
        }
        
        guard let pageControl = self.pageControl else{
            return
        }
         let pageControls = pageControl as!UIView
        self.view.addSubview(pageControls)
        pageControl.numberOfIndex = self.imageArray.count
        pageControl.selectIndex = self.currentIndex
        pageControls.frame = CGRect(x:kFullImageScreenWidth/2.0-100, y:kFullImageScreenHeight-20, width:200, height:20)
       
    }
    
    func prepareReuseImageViews() {
        let reuseViewCount = self.imageArray.count > 3 ? 3 : self.imageArray.count
        for _ in 0 ..< reuseViewCount  {
            let fullImageView = FullImageView(frame: self.view.bounds)
            self.reuseImageViewArray.append(fullImageView)
        }
    }

    func initializationAnimation() {
        self.modalPresentationStyle = .custom
        let fullImg = self.imageArray[self.currentIndex]
        let fullAnimation = FullImageAnimation()
        guard let orignalImageView = fullImg.originalImageView,let originalFrame = fullImg.originalFrame else {
            return
        }
        fullAnimation.image = self.screenshotfrom(imageView: orignalImageView)
        fullAnimation.originFrame = originalFrame
        self.animations = fullAnimation
    }
    
    func screenshotfrom(imageView:UIImageView) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, UIScreen.main.scale)
        imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let img = image ,let data = UIImagePNGRepresentation(img){
           return UIImage(data: data)
        }
        return nil
    }
}

// MARK: - Animations(进入浏览模式的动画)
extension FullImageViewController {
    
}

// MARK: - 图片滚动浏览
extension FullImageViewController {
   public func showImages() {
        self.scrollView?.subviews.forEach{
            $0.removeFromSuperview()
        }
        guard self.imageArray.count > 3 else {
            //图片数组小于等于3个
            for i in 0..<self.reuseImageViewArray.count {
                let fullImageView = self.reuseImageViewArray[i]
                self.update(fullImageView: fullImageView, index: i)
                if i == currentIndex {
                    currentImageView = fullImageView
                }
            }
            return
        }
        let currentIndexFullImageView = self.reuseImageViewArray[1]
        self.update(fullImageView: currentIndexFullImageView, index: self.currentIndex)
        currentImageView = currentIndexFullImageView
        if self.currentIndex - 1 > 0 {
            let previousImageView = self.reuseImageViewArray[0]
            self.update(fullImageView: previousImageView, index: self.currentIndex - 1)
        }
        if self.currentIndex + 1 <= self.imageArray.count - 1 {
            let nextImageView = self.reuseImageViewArray[2]
            self.update(fullImageView: nextImageView, index: self.currentIndex + 1)
        }
    }
    
   public func update(fullImageView:FullImageView, index:Int) {
        var rect = fullImageView.frame
        rect.origin.x = self.view.frame.width * CGFloat(index)
        fullImageView.frame = rect
        fullImageView.tag = index
        self.scrollView?.addSubview(fullImageView)
        guard index < self.imageArray.count else {
            return
        }
        let fullImage = self.imageArray[index]
        fullImageView.singleTapFullImage = self.singleTapFullImage
        fullImageView.updateImage(image: fullImage)
    }
    
}

extension FullImageViewController: UIScrollViewDelegate {
    
    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleBounds = scrollView.bounds
        var index = Int(visibleBounds.origin.x / visibleBounds.width)
        if index < 0 {
            index = 0
        }
        if (index > self.imageArray.count - 1) {
            index = self.imageArray.count - 1
        }
        guard index != self.currentIndex else {
            return
        }
        self.currentIndex = index
        self.pageControl?.selectIndex = index
        //
        if self.imageArray.count > 3 {
            showImages()
        }else {
            self.reuseImageViewArray.forEach{
                $0.resetFullImageView()
            }
        }
        
    }
}
