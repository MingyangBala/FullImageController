//
//  SingelPhotoTableViewCell.swift
//  FullImageController
//
//  Created by Mingyoung on 2017/8/16.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

/// 单张图片cell
class SinglePictureTableViewCell: UITableViewCell {
    @IBOutlet weak var singleBtn: UIButton!
   public var imageUrlString:String? {
        didSet {
            guard let imageUrl = imageUrlString else{
                return
            }
             self.singleBtn.kf.setBackgroundImage(with: URL(string:imageUrl), for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
