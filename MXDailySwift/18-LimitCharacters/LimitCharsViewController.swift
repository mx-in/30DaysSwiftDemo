//
//  LimitCharsViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/20.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class LimitCharsViewController: UIViewController {
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    static let maxTextCount = 140

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(LimitCharsViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LimitCharsViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @IBAction func didClickCloseBtn(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardInfo = self.keyboardInfo(from: notification)
        let userInfo = notification.userInfo
        let animations = makeAnimation(deltaY: -keyboardInfo.height)

        playBottomAnimations(animations, withDuration: keyboardInfo.duration, withAnimationOptions: animationOptions(from: userInfo!))
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardInfo = self.keyboardInfo(from: notification)
        let animations = makeAnimation(deltaY: keyboardInfo.height)
        
        playBottomAnimations(animations, withDuration: keyboardInfo.duration, withAnimationOptions: animationOptions(from: userInfo!))
    }
    
}

extension LimitCharsViewController {
    
    fileprivate func keyboardInfo(from notification: NSNotification) -> (height: CGFloat, duration: Double) {
        let userInfo = notification.userInfo
        
        let keyboardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        return (keyboardBounds.size.height, duration);
    }
    
    fileprivate func makeAnimation(deltaY: CGFloat) -> (() -> Void) {
        return {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: deltaY)
        }
    }
    
    func playBottomAnimations(_ animations: @escaping (() -> Void), withDuration duration: Double, withAnimationOptions options: UIViewAnimationOptions) {
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    fileprivate func animationOptions(from userInfo: [AnyHashable : Any]) -> UIViewAnimationOptions {
        return UIViewAnimationOptions(rawValue: (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uintValue << 16)
    }
}

extension LimitCharsViewController:  UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textStr = textView.text
        characterCountLabel.text = "\(140 - (textStr?.count)!)"
        
        if range.length > LimitCharsViewController.maxTextCount {
            return false
        }
        
        let newLength = (textStr?.count)! + range.length
        
        return newLength < LimitCharsViewController.maxTextCount
    }
}
