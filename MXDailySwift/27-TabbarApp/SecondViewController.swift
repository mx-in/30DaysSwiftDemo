//
//  SecondViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class SecondViewController: TabBaseViewController {

    @IBOutlet weak var exploreImage: UIImageView!
    
    override func viewDidLoad() {
        self.animateImageView = exploreImage
        super.viewDidLoad()
    }

}
