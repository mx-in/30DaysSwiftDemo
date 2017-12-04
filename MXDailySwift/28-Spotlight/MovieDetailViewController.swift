//
//  MovieDetailViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/4.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie? = nil
    
    @IBOutlet weak var movieCoverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ratingLabel.layer.cornerRadius = ratingLabel.frame.size.width / 2.0
        ratingLabel.layer.masksToBounds = true
        
        guard let _ = movie else {
            return
        }
        
        prepare(movie: movie!)
    }
    
    func prepare(movie: Movie) {
        movieCoverImage.image = UIImage(named: movie.coverImage)
        titleLabel.text = movie.title
        categoryLabel.text = movie.category
        descriptionLabel.text = movie.description
        ratingLabel.text = movie.rating
        directorLabel.text = movie.director
        starsLabel.text = movie.stars
    }

}
