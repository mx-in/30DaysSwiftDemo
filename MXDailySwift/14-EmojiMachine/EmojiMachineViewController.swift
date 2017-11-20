//
//  EmojiMachineViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class EmojiMachineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var emojiPickView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func goButtonTouched(_ sender: UIButton) {
        emojiPickView.selectRow(Int(arc4random() % 90 + 3), inComponent: 0, animated: true)
        emojiPickView.selectRow(Int(arc4random() % 90 + 3), inComponent: 1, animated: true)
        emojiPickView.selectRow(Int(arc4random() % 90 + 3), inComponent: 2, animated: true)
        
        if (dataArray1[emojiPickView.selectedRow(inComponent: 0)] == dataArray2[emojiPickView.selectedRow(inComponent: 1)] && dataArray2[emojiPickView.selectedRow(inComponent: 1)] == dataArray3[emojiPickView.selectedRow(inComponent: 2)] ) {
            scoreLabel.text = "Bingo!"
        } else {
            scoreLabel.text = "💔"
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: { 
           self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width + 20, height: self.bounds.height)
        }, completion: { (complete) in
            UIView.animate(withDuration: 0.1, delay: 0.0,  options: [], animations: {
                self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
            }, completion: nil)
        })
    }
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var bounds: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bounds = goButton.bounds
        imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
        
        for _ in 0..<100 {
            dataArray1.append((Int)(arc4random() % 10))
            dataArray2.append((Int)(arc4random() % 10))
            dataArray3.append((Int)(arc4random() % 10))
        }
        
        scoreLabel.text = ""
        
        emojiPickView.delegate = self
        emojiPickView.dataSource = self
        
        goButton.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goButton.alpha = 0.0;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.goButton.alpha = 1.0
        }, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickLabel = UILabel()
        
        if component == 0 {
            pickLabel.text = imageArray[dataArray1[row]]
        } else if component == 1 {
            pickLabel.text = imageArray[dataArray2[row]]
        } else {
            pickLabel.text = imageArray[dataArray3[row]]
        }
        
        pickLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickLabel.textAlignment = NSTextAlignment.center
        
        return pickLabel
    }
}


