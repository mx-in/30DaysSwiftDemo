//
//  SplashAnimation.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/3.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class SplashAnimation: NSObject, CAAnimationDelegate {
    var isNeedAnimation = false {
         didSet {
            if isNeedAnimation {
                self.addMask()
            }
        }
    }
    
    fileprivate var mask: CALayer = CALayer()
    var animationView: UIView?
    var imageView: UIImageView?
    
    init(at animationView: UIView) {
        self.animationView = animationView
    }
    
    fileprivate func addMask() {
        guard let _ = animationView, isNeedAnimation else {
            return
        }
        let imageView = UIImageView(frame: animationView!.frame)
        imageView.image = UIImage(named: "screen")
        animationView!.addSubview(imageView)
        
        mask.contents = UIImage(named: "twitter")?.cgImage
        mask.contentsGravity = kCAGravityResizeAspect
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: imageView.frame.size.width / 2, y: imageView.frame.size.height / 2)
        imageView.layer.mask = mask
        self.imageView = imageView
        
        animateMask()
        
        animationView!.backgroundColor = UIColor(red:0.117, green:0.631, blue:0.949, alpha:1)
    }
    
    fileprivate func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initialBounds = NSValue(cgRect: mask.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 73))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2600, height: 1600))
        keyFrameAnimation.values = [initialBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        mask.add(keyFrameAnimation, forKey: "bounds")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.imageView?.layer.mask = nil
    }
}
