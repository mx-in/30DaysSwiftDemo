//
//  PatternCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/27.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

struct Pattern {
    let image: String
    let name: String
}

class PatternCell: UITableViewCell {

    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var patternNameLabel: UILabel!
    
    func prepareCell(_ pattern: Pattern?) {
        guard let ptn = pattern else {
            return
        }
        patternImageView.image = UIImage(named: ptn.image)
        patternNameLabel.text = ptn.name
    }
    
}
