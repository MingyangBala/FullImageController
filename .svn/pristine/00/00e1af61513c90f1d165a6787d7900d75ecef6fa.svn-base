//
//  FNFullImageExtension.swift
//  Pods
//
//  Created by Mingyoung on 2017/8/17.
//
//

import UIKit
import Photos
import Kingfisher

//MARK: NavigationFullImageController
public class NavigationFullImageController: FullImageViewController {
    override public var currentIndex: Int {
        didSet {
            //更新图片pageIndex提示
            self.titleLabel?.text = "\(self.currentIndex+1)/\(self.imageArray.count)"
        }
    }
    weak var titleLabel:UILabel?
    weak var rightSaveBtn:UIButton?
    
    public required init?<T>(imageArray: Array<T>, currentIndex: Int, pageControlType: FIPageControlType) where T : FNFullImage {
        super.init(imageArray: imageArray, currentIndex: currentIndex, pageControlType: pageControlType)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }

    //MARK: initialize ui
    func initializeUI() {
        //设置导航栏
      configureNavigation()
        
    }
    
    override public func showImages() {
        //设置单次点击图片效果
        self.singleTapFullImage = {[weak self] _ in
            self?.hideNavigationBar(hidden: !(self?.navigationController?.isNavigationBarHidden)!)
        }
        super.showImages()
    }
    
    func configureNavigation() {
        assert(self.navigationController != nil, "NavigationFullImageController's navigationBar must exist")
        //设置naviagtionBar
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 21))
        titleLabel.text = "\(self.currentIndex+1)/\(self.imageArray.count)"
        self.navigationItem.titleView = titleLabel
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        
        let leftBtn = UIButton(type: .custom)
        let leftImage = UIImage(named: "icon_return", in: Bundle(for: NavigationFullImageController.self), compatibleWith: nil)
        leftBtn.addTarget(self, action: #selector(self.leftBackBtnTouched(_:)), for: .touchUpInside)
        leftBtn.setImage(leftImage, for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: leftImage?.size.width ?? 0, height: leftImage?.size.height ?? 0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = UIButton(type: .custom)
        let rightImage = UIImage(named: "icon_photo_more", in: Bundle(for: NavigationFullImageController.self), compatibleWith: nil)
        rightBtn.addTarget(self, action: #selector(self.rightSaveImgBtnTouched(_:)), for: .touchUpInside)
        rightBtn.frame = CGRect(x: 0, y: 0, width: rightImage?.size.width ?? 0, height: rightImage?.size.height ?? 0)
        rightBtn.setImage(rightImage, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    func leftBackBtnTouched(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //弹出actionsheet,展示是否保存可选项
    func rightSaveImgBtnTouched(_ sender: UIButton){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "保存到相册", style: .default, handler: {_ in
            self.saveImage()
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func saveImage() {
        guard let currentIndexImageView = currentImageView,let image = currentIndexImageView.fullImageView?.image else {
            showToast(message: "保存失败")
            return
        }
        PHPhotoLibrary.shared().performChanges({ 
           //写入图片到相册
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: {
            success, error in
            let message = success ? "保存成功":"保存失败"
            DispatchQueue.main.async {
               self.showToast(message: message)
            }
            print("message: \(message)")
        })
    }
    
    func showToast(message:String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.center = self.view.center
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        UIApplication.shared.keyWindow?.addSubview(label)
        UIApplication.shared.keyWindow?.bringSubview(toFront: label)
        label.text = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            label.removeFromSuperview()
        }
    }
    
    func hideNavigationBar(hidden:Bool) {
        self.navigationController?.isNavigationBarHidden = hidden
    }
    override public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        //隐藏navigationBar
        hideNavigationBar(hidden: true)
    }
}


 public protocol Comment {
    var headUrl:String? { get }
    var nickName:String? { get }
    var commentMsg:String? { get }
    var pageIndexTint:String? { set get } //pgae index 提示
}

public typealias CommentImage = Comment & FNFullImage


public struct CommentFullImage:CommentImage {
    public var pageIndexTint: String?
    public var commentMsg: String?
    public var nickName: String?
    public var headUrl: String?
    public var originalImage:UIImage?
    public var imageUrlString:String?
    public var originalImageView:UIImageView?
    public var originalFrame: CGRect?
    
    public init(originalImage:UIImage? = nil , imageUrlString:String? = nil, originalImageView:UIImageView? = nil, originalFrame: CGRect? = nil,pageIndexTint: String? = nil ,commentMsg: String? = nil ,nickName: String? = nil ,headUrl: String? = nil ) {
        self.originalImage = originalImage
        self.imageUrlString = imageUrlString
        self.originalImageView = originalImageView
        self.originalFrame = originalFrame
        self.pageIndexTint = pageIndexTint
        self.commentMsg = commentMsg
        self.nickName = nickName
        self.headUrl = headUrl
    }
    
}

//MARK: 评论浏览大图
public class CommentFullImageController : FullImageViewController {
    var commentImageArray:Array<CommentImage>
    weak var commentInfoView:CommentFIDetailInfoView?
   public override var currentIndex: Int {
        didSet {
            //更新当前评论视图的信息
            let commentImage = self.commentImageArray[self.currentIndex]
            self.commentInfoView?.commentImage = commentImage
        }
    }
    
   public required init?<T>(imageArray: Array<T>, currentIndex: Int, pageControlType: FIPageControlType) where T : CommentImage {
        self.commentImageArray = imageArray
        super.init(imageArray: imageArray, currentIndex: currentIndex, pageControlType: .none)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public override func viewDidLoad() {
        super.viewDidLoad()
        addCommentDetailInfoView()
        self.currentIndex = 0
    }
    
    func addCommentDetailInfoView() {
        let commentInfoView = CommentFIDetailInfoView(frame:CGRect.zero)
        self.view.addSubview(commentInfoView)
       self.commentInfoView = commentInfoView
    }
}

class CommentFIDetailInfoView : UIView {
    weak var headImageIcon:UIImageView? //头像
    weak var nickNameLabel:UILabel? //昵称
    weak var pageTintLabel:UILabel? //图片page index提示
    weak var commentMsgLabel:UITextView? //评论内容
    var commentImage:CommentImage? {
        didSet {
           refreshCommentInfo()
        }
    }
    
     override init (frame:CGRect) {
        super.init(frame:frame)
        initlializeInfoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         initlializeInfoView()
    }
    
    func initlializeInfoView() {
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        let headImageIcon = UIImageView(frame:CGRect(x: 20, y: 10, width: 25, height: 25))
        headImageIcon.layer.cornerRadius = headImageIcon.frame.width * 0.5
        headImageIcon.layer.masksToBounds = true
        self.addSubview(headImageIcon)
        self.headImageIcon = headImageIcon
        
        let nickNameLabel = UILabel(frame:CGRect(x: headImageIcon.frame.maxX + 10, y: headImageIcon.frame.minY, width: 100, height: 25))
        self.addSubview(nickNameLabel)
        self.nickNameLabel = nickNameLabel
        nickNameLabel.font = UIFont.systemFont(ofSize: 14)
        nickNameLabel.textColor = UIColor.white
        
        //pageindex
        let pageIndexLabel = UILabel(frame:CGRect(x: kFullImageScreenWidth - 100, y: headImageIcon.frame.minY, width: 88, height: 25))
        pageIndexLabel.font = UIFont.systemFont(ofSize: 14)
        pageIndexLabel.textAlignment = .center
        pageIndexLabel.textColor = UIColor.white
        self.addSubview(pageIndexLabel)
        self.pageTintLabel = pageIndexLabel
        
        let commentContentTextView = UITextView(frame:CGRect.init(x: 0, y: 45, width: kFullImageScreenWidth, height: 80))
        commentContentTextView.isEditable = false
        commentContentTextView.isSelectable = false
        commentContentTextView.backgroundColor = UIColor.clear
        commentContentTextView.indicatorStyle = .white
        commentContentTextView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        commentContentTextView.alwaysBounceVertical = true
        commentContentTextView.showsVerticalScrollIndicator = false
        commentContentTextView.showsHorizontalScrollIndicator = false
        commentContentTextView.alwaysBounceHorizontal = false
        self.addSubview(commentContentTextView)
        self.commentMsgLabel = commentContentTextView
        let height = commentContentTextView.frame.height + 50
        self.frame = CGRect(x: 0, y: kFullImageScreenHeight - height, width: kFullImageScreenWidth, height: height)
    }
    
    func refreshCommentInfo() {
        //image icon
        self.headImageIcon?.kf.setImage(with: URL(string:(commentImage?.headUrl)!), placeholder: nil, options: [KingfisherOptionsInfoItem.targetCache(ImageCache.default)], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            
        })
        
        //nick name
        self.nickNameLabel?.text = commentImage?.nickName
        self.commentMsgLabel?.text = commentImage?.commentMsg
        self.pageTintLabel?.text = commentImage?.pageIndexTint
        self.commentMsgLabel?.attributedText = NSAttributedString.init(string: commentImage?.commentMsg ?? "", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.white])
    }
}


