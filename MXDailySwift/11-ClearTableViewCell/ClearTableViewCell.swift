//
//  ClearTableViewCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ClearTableViewCell: UITableViewCell {

    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        gradientLayer.frame = self.bounds
        
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor 
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor
        let color3 = UIColor.clear.cgColor
        let color4 = UIColor(white: 0.0, alpha: 0.05).cgColor
        
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.04, 0.95, 1.0]
//        layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    
}
