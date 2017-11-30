//
//  ColorViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {

        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: { () -> Void in
            
            self.backgroundView.backgroundColor = UIColor.black
            
        }, completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: { () -> Void in
            
            self.nameLabel.textColor = UIColor(red:0.959, green:0.937, blue:0.109, alpha:1)
            
        }, completion: nil)
        
    }

}
