//
//  FullImageAnimations.swift
//  Pods
//
//  Created by Mingyoung on 2017/8/11.
//
//

import UIKit

public class BaseAnimatedTransitioning : NSObject {
    var presented = false
    var operation:UINavigationControllerOperation?
}

extension BaseAnimatedTransitioning : UIViewControllerAnimatedTransitioning {
    // This is used for percent driven interactive transitions, as well as for
    // container controllers that have companion animations that might need to
    // synchronize with the main animation.
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.26
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}

extension BaseAnimatedTransitioning : UIViewControllerTransitioningDelegate {
     public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}


class FullImageAnimation: BaseAnimatedTransitioning {
    var image:UIImage?
    var originFrame:CGRect?
    var disappearIntoMiddleOfAnimation = false
}

//MARK: UIViewControllerAnimatedTransitioning Override
extension FullImageAnimation {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let image = self.image,let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        let containerView = transitionContext.containerView
        fromVc.view.frame = CGRect(x: 0, y: 0, width: kFullImageScreenWidth, height: kFullImageScreenHeight)
        toVc.view.frame = fromVc.view.frame
        containerView.addSubview(fromVc.view)
        containerView.addSubview(toVc.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        if self.presented {
            let bgView = UIView(frame: toVc.view.frame)
            bgView.backgroundColor = UIColor.black
            containerView.addSubview(bgView)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            containerView.addSubview(imageView)
            fromVc.view.isHidden = true
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                imageView.frame = self.disappearIntoMiddleOfAnimation ? CGRect(x:kFullImageScreenWidth/2.0, y:kFullImageScreenHeight/2.0, width:0, height:0):self.originFrame!;
                bgView.alpha = 0;
            }, completion: {
                _ in
                imageView.removeFromSuperview()
                bgView.removeFromSuperview()
                self.presented = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                UIApplication.shared.keyWindow?.addSubview(toVc.view)
            })
        }else {
            toVc.view.isHidden = true
            let bgView = UIView(frame: toVc.view.frame)
            bgView.alpha = 0
            bgView.backgroundColor = UIColor.black
            containerView.addSubview(bgView)
            let imageView = UIImageView(image: image)
            imageView.frame = self.originFrame!
            imageView.contentMode = .scaleAspectFit
            containerView.addSubview(imageView)
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
               bgView.alpha = 1
              imageView.frame = UIScreen.main.bounds
            }, completion: {
                _ in
                imageView.removeFromSuperview()
                bgView.removeFromSuperview()
                self.presented = true
                toVc.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
