//
//  FullImageView.swift
//  Pods
//
//  Created by Mingyoung on 2017/8/10.
//
//

import UIKit
import Kingfisher

/// 展示单个图片的imageView
public class FullImageView: UIView {
    weak var fullImageView:UIImageView?
    weak var placeholder:UIImage?
    weak var fullScrollView:UIScrollView?
    var singleTapFullImage:((_ fullImageView:FullImageView)->Void)? //退出页面处理
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //scrollViw
        let scrollView = UIScrollView(frame: self.frame)
        self.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        self.fullScrollView = scrollView
        
        //imageView
        let imageView = UIImageView(frame: self.frame)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        self.fullImageView = imageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesuture))
         imageView.addGestureRecognizer(tapGesture)
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTapGesture))
        doubleTapGesture.numberOfTapsRequired = 2
        tapGesture.require(toFail: doubleTapGesture)
        imageView.addGestureRecognizer(doubleTapGesture)
    }
    
    
    /// 双击图片，缩放图片
    func handleDoubleTapGesture(tap:UITapGestureRecognizer) {
        guard let zoomScale = self.fullScrollView?.zoomScale else {
            return;
        }
        if (zoomScale == 1) {
            self.fullScrollView?.setZoomScale(2, animated: true)
        } else if (zoomScale == 2) {
            self.fullScrollView?.setZoomScale(1, animated: true)
        }else if (zoomScale >= 1.5) {
            self.fullScrollView?.setZoomScale(2, animated: true)
        } else if (zoomScale < 1) {
            self.fullScrollView?.setZoomScale(1, animated: true)
        }
        layoutIfNeeded()
    }
    
    /// 单次点击图片，退出
    func handleTapGesuture(tap:UITapGestureRecognizer) {
        if let singleTapFullImage = self.singleTapFullImage {
            singleTapFullImage(self)
        }
    }
}

//MARK: Public Api
extension FullImageView {
    /// 更新imageView的image
    ///
    /// - Parameters:
    ///   - image: FNFullImage
    ///   - completion: 更新完成
    func updateImage(image: FNFullImage, completion: (() -> Void)? = nil) {
        if let fullImg = image.originalImage {
            self.fullImageView?.image = fullImg
        }else if let imageUrl = image.imageUrlString {
            self.fullImageView?.kf.setImage(with: URL(string:imageUrl), placeholder: nil, options:[KingfisherOptionsInfoItem.targetCache(ImageCache.default)] , progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                //                print(error ?? <#default value#>)
            })
        }
        resetFullImageView()
    }
    
    /// 重置imageView的大小，
    func resetFullImageView() {
        self.fullScrollView?.setZoomScale(1.0, animated: false)
    }
}

// MARK: - UIScrollViewDelegate
extension FullImageView : UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.fullImageView
    }
}
