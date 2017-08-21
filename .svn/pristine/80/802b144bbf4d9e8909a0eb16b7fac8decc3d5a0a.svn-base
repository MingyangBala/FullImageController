//
//  ViewController.swift
//  FullImageController
//
//  Created by Minyoung on 08/10/2017.
//  Copyright (c) 2017 Minyoung. All rights reserved.
//

import UIKit
import FullImageController




class ViewController: UITableViewController {
    var imagesUrl:Array<String> = []
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: data initialize
    func setupDataArray() {
         imagesUrl = [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502704002702&di=c273465f4f89e7808a74cadd8a33c874&imgtype=0&src=http%3A%2F%2Fwww.whtlhq.com%2Fpics%2Fbd6150300.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502704002093&di=6d9e99d0b30da7b92d767a3ea834eff1&imgtype=0&src=http%3A%2F%2Fimg.qqzhi.com%2Fupload%2Fimg_4_4035755785D1461474169_23.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502712733690&di=92762e12cca38e08801dd1bd8859831e&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D676435523%2C3601822844%26fm%3D214%26gp%3D0.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502706673055&di=1053d041ae3d828c54ce5119e6c271b0&imgtype=0&src=http%3A%2F%2Fimg5.goumin.com%2Fattachments%2Fmonth_1402%2F14%2F353570717.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502712814035&di=565704aaa1a5c98f63bbd40fe5070acf&imgtype=0&src=http%3A%2F%2Fimg4.cache.netease.com%2Fsports%2F2009%2F10%2F31%2F20091031152438fe185.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502712862940&di=13f052a3f0929dbbadf603e8b62011f0&imgtype=0&src=http%3A%2F%2Fjiangsu.china.com.cn%2Fuploadfile%2F2016%2F0927%2F1474976006006717.jpg"]
      
    }
    
}

//MARK: Picture target action

extension ViewController {
    @IBAction func signleButtonIconTouched(_ sender: UIButton) {
     presentFullImageController(imageView: sender,index: 0)
    }
    @IBAction func leftMultiplePictureButtonTouched(_ sender: UIButton) {
//        presentFullImageController(imageView: sender,index: 1)
        
        let imageArray:Array<CommentFullImage> = imagesUrl.map({
            let originalFrame = sender.superview?.convert(sender.frame, to: self.view.window)
            var fullImage = CommentFullImage()
            let originalImageView = UIImageView(frame: sender.frame)
            fullImage.imageUrlString = $0
            fullImage.originalImageView = originalImageView
            fullImage.originalFrame = originalFrame
            fullImage.headUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502712862940&di=13f052a3f0929dbbadf603e8b62011f0&imgtype=0&src=http%3A%2F%2Fjiangsu.china.com.cn%2Fuploadfile%2F2016%2F0927%2F1474976006006717.jpg"
            fullImage.commentMsg = "nihaoiooooooooooooo99999999999222222223333333333"
            fullImage.nickName = "who are you"
            fullImage.pageIndexTint = "1+1"
            return fullImage
        })
        
        let navFullImageController = CommentFullImageController(imageArray: imageArray, currentIndex: 1, pageControlType: .defaultControl)
        self.present(navFullImageController!, animated: true)
        
    }
    @IBAction func rightMultiplePictureButtonTouched(_ sender: UIButton) {
        let imageArray:Array<FNFullScreenImage> = imagesUrl.map({
            let originalFrame = sender.superview?.convert(sender.frame, to: self.view.window)
            var fullImage = FNFullScreenImage()
            let originalImageView = UIImageView(frame: sender.frame)
            fullImage.imageUrlString = $0
            fullImage.originalImageView = originalImageView
            fullImage.originalFrame = originalFrame
            return fullImage
        })
        
        let navFullImageController = NavigationFullImageController(imageArray: imageArray, currentIndex: 3, pageControlType: .defaultControl)
        self.navigationController?.pushViewController(navFullImageController!, animated: true)
    }
    @IBAction func wechatAnimationBtnTouched(_ sender: UIButton) {

        presentFullImageController(imageView: sender,index: 4)
    }
    
    func presentFullImageController(imageView sender:UIView ,index:Int ){
        
//       1.***
        /*
         var imageArray:Array<FNFullScreenImage> = []
         imagesUrl.forEach{
            let originalFrame = sender.superview?.convert(sender.frame, to: self.view.window)
//            var originalFrame = self.tableView.convert(originalFrame0!, to: self.view)
//            originalFrame.origin.y += (self.navigationController?.navigationBar.frame.height)! + 20
            var fullImage = FNFullScreenImage()
            let originalImageView = UIImageView(frame: sender.frame)
            fullImage.imageUrlString = $0
            fullImage.originalImageView = originalImageView
            fullImage.originalFrame = originalFrame
            imageArray.append(fullImage)
        }
  */
        //2.***
        let imageArray:Array<FNFullScreenImage> = imagesUrl.map({
            let originalFrame = sender.superview?.convert(sender.frame, to: self.view.window)
            var fullImage = FNFullScreenImage()
            let originalImageView = UIImageView(frame: sender.frame)
            fullImage.imageUrlString = $0
            fullImage.originalImageView = originalImageView
            fullImage.originalFrame = originalFrame
            return fullImage
        })
        
        let controller = FullImageViewController(imageArray: imageArray, currentIndex: index, pageControlType: .defaultControl)
        self.present(controller!, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.row % 3 {
        case 0:
           let singlecell = tableView.dequeueReusableCell(withIdentifier: SinglePictureTableViewCell.reuseIdentifier) as! SinglePictureTableViewCell
            singlecell.imageUrlString = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502704002702&di=c273465f4f89e7808a74cadd8a33c874&imgtype=0&src=http%3A%2F%2Fwww.whtlhq.com%2Fpics%2Fbd6150300.jpg"
            return singlecell
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: MultiplePicturesTableViewCell.reuseIdentifier)!
        
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: WechatAnimationsPictureTableViewCell.reuseIdentifier)!
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        switch indexPath.row % 3 {
        case 0: height = 190
        case 1: height = 280
        default: height = UIScreen.main.bounds.width / (50 / 61)
        }
        return height
    }
}

