//
//  ScaleViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var scaleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scaleImageView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void in
            
            self.scaleImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.scaleImageView.alpha = 1
            
        }, completion: nil )
        
    }
}
