//
//  MenuTransitionManager.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/15.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class TumblrMenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = false
    
    fileprivate func offStageMenuController(menuViewController: MenuViewController) {
        menuViewController.view.alpha = 0.0
        
        let topRowOffset: CGFloat = 300.0
        let middleOffset: CGFloat = 150.0
        let bottomOffset:CGFloat = 50.0
        
        self.transform(uiElements: [menuViewController.textButton, menuViewController.textLabel], offset: -topRowOffset)
        self.transform(uiElements: [menuViewController.quoteButton, menuViewController.quoteLabel
            ], offset: -middleOffset)
        self.transform(uiElements: [menuViewController.chatButton, menuViewController.chatLabel], offset: -bottomOffset)
        
        self.transform(uiElements: [menuViewController.photoButton, menuViewController.photoLabel], offset: topRowOffset)
        self.transform(uiElements: [menuViewController.linkButton, menuViewController.linkLabel
            ], offset: middleOffset)
        self.transform(uiElements: [menuViewController.audioButton, menuViewController.audioLabel], offset: bottomOffset)
    }
    

    fileprivate func onStageMenuController(menuViewController: MenuViewController) {
        
        menuViewController.view.alpha = 1;
        
        let uiElements: [UIView] = [menuViewController.textButton, menuViewController.textLabel, menuViewController.quoteButton, menuViewController.quoteLabel, menuViewController.chatButton, menuViewController.chatLabel, menuViewController.photoButton, menuViewController.photoLabel, menuViewController.linkButton, menuViewController.linkLabel, menuViewController.audioButton, menuViewController.audioLabel]
        
        self.transform(uiElements: uiElements, cgAffineTransform: CGAffineTransform.identity)
    }
    
    fileprivate func transform(uiElements: Array<UIView>, cgAffineTransform: CGAffineTransform) {
        _ = uiElements.map {
            $0.transform = cgAffineTransform
        }
    }
    
    fileprivate func transform(uiElements: Array<UIView>, offset: CGFloat) {
        _ = uiElements.map {
            $0.transform = self.offstage(offsetX: offset)
        }
    }
    
    fileprivate func offstage(offsetX: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: offsetX, y: 0)
    }
    
    // MARK:- UIViewControllerAnimatedTransitioning
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        let screens : (from: UIViewController, to: UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if self.presenting {
            self.offStageMenuController(menuViewController: menuViewController)
        }
        
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
            
            if self.presenting {
                
                self.onStageMenuController(menuViewController: menuViewController)

            } else {
                
                self.offStageMenuController(menuViewController: menuViewController)
            }

        }) { finish in
            
            transitionContext.completeTransition(true)
// ??         UIApplication.shared.keyWindow!.addSubview(screens.to.view)
            
        }
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    //MARK:- UIViewControllerAnimatedTransitioning
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
