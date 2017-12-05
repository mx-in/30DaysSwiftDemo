//
//  MoviesTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/3.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class MoviesTableViewController: UITableViewController {

    let cellIdentifier = "movieCell"
    let pushDetailIdentifier = "ShowMovieDetails"
    
    var spManager = SpotlightManager()
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spManager.setupSearchableContent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == pushDetailIdentifier {
            let detailVC = segue.destination as! MovieDetailViewController
            
            guard let movieDic = spManager.movie(at: selectedIndex) else {
                return
            }
            detailVC.movie = Movie(movieDic: movieDic)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = spManager.moviesInfo else {
            return 0
        }
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieSummaryCell
        
        guard let movieDic = spManager.movie(at: indexPath.row) else {
            return cell
        }
        let movie = Movie(movieDic: movieDic)
        cell.prepareCell(withMovie: movie)
        
        return cell
    }
    
    // MARK: - Table view delegate
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: pushDetailIdentifier, sender: self)
    }
}

extension MoviesTableViewController {
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo {
                let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as! String
                selectedIndex = Int(selectedMovie.components(separatedBy: ".").last!)
        
                self.performSegue(withIdentifier: pushDetailIdentifier, sender: self)
            }
        }
    }
    
}
