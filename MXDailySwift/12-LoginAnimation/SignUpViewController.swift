//
//  SignUpViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/31.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var centerAlignUserName: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.alpha = 0.0
        centerAlignUserName.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        You need to call layoutIfNeeded(to parent view) within the animation block. Apple actually recommends you call it once before the animation block to ensure that all pending layout operations have been completed
        UIView.animate(withDuration: 0.5, delay: 0.0, options:.curveEaseOut, animations: {
            self.centerAlignUserName.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options:.curveEaseOut, animations: {
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options:.curveEaseOut, animations: {
            self.loginButton.alpha = 1.0
        }, completion: nil)
    }
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.isHidden = true
        userNameTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.cornerRadius = 5.0
        loginButton.layer.cornerRadius = 5.0
    }

    @IBAction func loginButtonTouched(_ sender: UIButton) {
        let bound = loginButton.bounds
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.loginButton.bounds = CGRect(x: bound.origin.x - 20, y: bound.origin.y, width: bound.size.width + 40, height: bound.size.height)
            self.loginButton.isEnabled = false
        }) { finish in
            self.loginButton.isEnabled = true
        }
    }
}
