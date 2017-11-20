//
//  LoginViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/31.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginHightConstraint: NSLayoutConstraint!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
    }

}
