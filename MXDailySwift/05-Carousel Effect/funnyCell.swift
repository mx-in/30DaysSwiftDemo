//
//  funnyCell.swift
//  MXCarousel Effect
//
//  Created by mx_in on 16/12/14.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class funnyCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImg: UIImageView!
    @IBOutlet weak var funnyTitleLabel: UILabel!
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true;
    }
    
    fileprivate func updateUI() {
        featuredImg.image = funny.featuredImage
        funnyTitleLabel.text = funny.description
    }
    
     var funny: funny! {
        didSet {
            self.updateUI()
        }
    }
    
}
