//
//  ThirdViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ThirdViewController: TabBaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        self.animateImageView = profileImageView
        super.viewDidLoad()
    }

}
