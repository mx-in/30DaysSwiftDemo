//
//  VideoBackgroundVC.swift
//  DailySwift
//
//  Created by mx_in on 16/12/18.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class VideoBackgroundVC: VideoSplashViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        loginButton.layer.cornerRadius = 4.0
        signUpButton.layer.cornerRadius = 4.0
        
        setupVideoBackground()
    }
    
    func setupVideoBackground() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
//        view.isUserInteractionEnabled = false
    }
    
}
    
