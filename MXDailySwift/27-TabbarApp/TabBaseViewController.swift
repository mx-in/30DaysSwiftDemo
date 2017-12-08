//
//  TabBaseViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class TabBaseViewController: UIViewController {

    var animateImageView: UIImageView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imageView = animateImageView else {
            return
        }
        
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void in
            
            guard let imageView = self.animateImageView else {
                return
            }
            imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            imageView.alpha = 1
            
        }, completion: nil )
    }

}
