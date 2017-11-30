//
//  PositionViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {

    @IBOutlet weak var leftEye: UIView!
    @IBOutlet weak var rightEye: UIView!
    @IBOutlet weak var mouse: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions(), animations: {
            self.leftEye.center.x = self.view.bounds.width - self.leftEye.center.x
            self.leftEye.center.y = self.leftEye.center.y + 30
            self.rightEye.center.x = self.view.bounds.width - self.rightEye.center.x
            self.rightEye.center.y = self.rightEye.center.y + 30
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.setHeight(self.mouse.frame.size.height + 50.0)
            self.mouse.center.y = self.view.bounds.height - self.mouse.center.y
        }, completion: nil)
    }

    func setHeight(_ height: CGFloat) {
        var mouseFrame = mouse.frame
        mouseFrame.size.height = height
        
        mouse.frame = mouseFrame
    }

}
