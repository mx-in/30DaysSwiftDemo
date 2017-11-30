//
//  RotationViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.spin()
    }
    
    func spin() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            _ = self.view.subviews.map { view in
                view.transform = view.transform.rotated(by: CGFloat(Double.pi))
            }
        }) { _ in
           self.spin()
        }
    }

}
