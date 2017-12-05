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

    var quickActionHandler = QuickActionHandler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            quickActionHandler.launchedShortcutItem = shortcutItem
        }
        
//        let showAnimation = true // let it be true if you want to show animation splash
        
        let showAnimation = false
        
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
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let shortcut = quickActionHandler.launchedShortcutItem {
            _ = quickActionHandler.handleShortcutItem(shortcut)
            quickActionHandler.launchedShortcutItem = nil
        }
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let isHandled = quickActionHandler.handleShortcutItem(shortcutItem)
        completionHandler(isHandled)
    }
    
//28-Spotlight
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        var viewControllers: [UIViewController] {
           return (window?.rootViewController as! UINavigationController).viewControllers
        }
        
        var lastVC: UIViewController {
            return viewControllers.last!
        }
        
        func showSpolightVC() {
            lastVC.performSegue(withIdentifier: "Spotlight", sender: nil)
            print(viewControllers)
            print(lastVC)
            lastVC.restoreUserActivityState(userActivity)
        }
        
        if lastVC.self.isKind(of: ProjViewController.self) {
            showSpolightVC()
            
        } else if lastVC.self.isKind(of: MoviesTableViewController.self) {
            lastVC.restoreUserActivityState(userActivity)
            
        } else {
            lastVC.navigationController!.popToViewController(viewControllers[0], animated: false)
//          ???? why must to wait for a minutes, otherwise MoviesViewController not in controllers
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                showSpolightVC()
            })
        }
        
        return true
    }
}

