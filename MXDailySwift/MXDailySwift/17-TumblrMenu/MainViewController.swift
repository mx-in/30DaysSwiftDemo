//
//  MainViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/15.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }

}
