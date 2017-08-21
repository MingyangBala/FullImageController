//
//  FullImage.swift
//  Pods
//
//  Created by Mingyoung on 2017/8/10.
//
//

import UIKit

public  protocol FullImage {
    var originalImage:UIImage? { get }
    var imageUrlString:String? { get }
}

public protocol FNFullImage:FullImage {
    /// 进入小图看大图，动画使用
    var originalImageView:UIImageView? { get }
    var originalFrame:CGRect? { get }
}


public struct FNFullScreenImage: FNFullImage {
    public var originalImage:UIImage?
    public var imageUrlString:String?
    public var originalImageView:UIImageView?
    public var originalFrame: CGRect?
    
    public init(originalImage:UIImage? = nil , imageUrlString:String? = nil, originalImageView:UIImageView? = nil, originalFrame: CGRect? = nil) {
        self.originalImage = originalImage
        self.imageUrlString = imageUrlString
        self.originalImageView = originalImageView
        self.originalFrame = originalFrame
    }
}

//public typealias FNFullImage = FullImage & AnimaiteFullImage


