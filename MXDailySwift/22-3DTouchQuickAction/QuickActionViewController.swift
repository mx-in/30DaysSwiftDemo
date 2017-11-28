//
//  QuickActionViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class QuickActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}
