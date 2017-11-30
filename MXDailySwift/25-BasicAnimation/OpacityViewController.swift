//
//  OpacityViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet weak var ascllArtImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2.0) {
            self.ascllArtImageView.alpha = 0.0
        }
    }

}
