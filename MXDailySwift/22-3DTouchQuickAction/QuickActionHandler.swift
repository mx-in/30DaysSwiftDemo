//
//  QuickActionHandler.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/28.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

struct QuickActionHandler {
    
    struct Constants {
        static let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        static let rootVC = (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController
    }
    
    enum ShortCutIdentifier: String {
        case First
        case Second
        case Third
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else {
                return nil
            }

            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }

    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        

        guard let identifier = ShortCutIdentifier(fullType: shortcutItem.type) else {
            return false
        }
        
        var presentedVC: UIViewController?
        
        func generateVC(identifier: String) -> UIViewController {
            return Constants.storyBoard.instantiateViewController(withIdentifier: identifier)
        }
        
        var handled = true
        switch identifier.type {
        case ShortCutIdentifier.First.type:
            presentedVC = generateVC(identifier: "RunVC")
            break
        case ShortCutIdentifier.Second.type:
            presentedVC = generateVC(identifier: "ScanVC")
            break
        case ShortCutIdentifier.Third.type:
            presentedVC = generateVC(identifier: "WiFiVC")
            break
        default:
            handled = false
            break
        }
        
        guard let _ = Constants.rootVC, let _ = presentedVC else {
            return false
        }
        Constants.rootVC!.present(presentedVC!, animated: true, completion: nil)
        
        return handled
    }
    
}
