//
//  MenuViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/15.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let transitionManager = TumblrMenuTransitionManager()

    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var chatLabel: UILabel!
    
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var audioLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager;

    }

}
