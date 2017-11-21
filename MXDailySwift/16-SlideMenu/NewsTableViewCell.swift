//
//  NewsTableViewCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postAuthorImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAuthor: UILabel!
    
    override func awakeFromNib() {
        postAuthorImageView.layer.cornerRadius = postAuthorImageView.frame.size.width / 2
        postAuthorImageView.layer.masksToBounds = true
    }

}
