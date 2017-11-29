//
//  RevealAbleViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class RevealAbleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
//        self.navigationController?.isNavigationBarHidden = true
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }

}
