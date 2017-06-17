//
//  ManuTransitionManager.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/15.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dissmiss()
}

class MenuTransitionManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    
    var delegate: MenuTransitionManagerDelegate?
    
    var duration = 0.5
    var isPresenting = false
    var snapshot: UIView? {
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: #selector(_delegate.dissmiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    //    MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        if isPresenting {
            toView.transform = moveDown
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
            
        }, completion: { finish in
            
            transitionContext.completeTransition(true)
            
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
}
