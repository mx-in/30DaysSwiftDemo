//
//  MovieSummaryCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/4.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

struct Movie {
    let coverImage: String
    let title: String
    let description: String
    let rating: String
    let category: String
    let director: String
    let stars: String
    
    init(movieDic: [String : String]) {
        coverImage = movieDic["Image"]!
        title =  movieDic["Title"]!
        description = movieDic["Description"]!
        rating = movieDic["Rating"]!
        category = movieDic["Category"]!
        director = movieDic["Director"]!
        stars = movieDic["Stars"]!
        
    }
}


class MovieSummaryCell: UITableViewCell {

    @IBOutlet weak var movieCoverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func prepareCell(withMovie movie: Movie) {
        movieCoverImage.image = UIImage(named: movie.coverImage)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
        ratingLabel.text = movie.rating
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
