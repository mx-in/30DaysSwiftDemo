//
//  AppDelegate.swift
//  MXDailySwift
//
//  Created by mx_in on 16/12/16.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mask: CALayer?
    var imageView: UIImageView?
    var splashAnimation: SplashAnimation?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let showAnimation = true // let it be true if you want to show animation splash
        
        guard showAnimation else {
            return true
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // confuse about animation didn't show in RootViewController
        //        let rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RootViewController")
        //        self.window?.rootViewController = rootViewController
        self.window?.rootViewController = UIViewController()
        let sAnimation = SplashAnimation(at: self.window!)
        sAnimation.isNeedAnimation = showAnimation
        
        self.splashAnimation = sAnimation
        self.window!.backgroundColor = UIColor(red:0.117, green:0.631, blue:0.949, alpha:1)
        self.window!.makeKeyAndVisible()
        UIApplication.shared.isStatusBarHidden = true
        
        return true
    }
}

