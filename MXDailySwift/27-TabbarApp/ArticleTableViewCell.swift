//
//  ArticleTableViewCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

struct Article {
    let avatarImage: String
    let sharedName: String
    let actionType: String
    let articleTitle: String
    let articleCoverImage: String
    let articleSource: String
    let articleTime: String
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var shareNameLabel: UILabel!
    @IBOutlet weak var shareCover: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!
    
    func prepareCell(_ article: Article) {
        avatar.image = UIImage(named: article.avatarImage)
        shareNameLabel.text = article.sharedName
        shareCover.image = UIImage(named: article.articleCoverImage)
        articleTitleLabel.text = article.articleTitle
        createdTimeLabel.text = article.articleTime
        articleSourceLabel.text = article.articleSource
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

}
