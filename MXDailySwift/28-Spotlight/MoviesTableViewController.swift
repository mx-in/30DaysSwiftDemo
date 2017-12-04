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
    
    var moviesInfos: NSMutableArray!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMoviesInfo()
        setupSearchableContent()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == pushDetailIdentifier {
            let detailVC = segue.destination as! MovieDetailViewController
            let movie = Movie(movieDic: moviesInfos[selectedIndex] as! [String : String])
            detailVC.movie = movie
        }
    }
    
    func loadMoviesInfo() {
        let resourceName = "MoviesData"
        let resourceType = "plist"

        if let path = Bundle.main.path(forResource: resourceName, ofType: resourceType) {
            moviesInfos = NSMutableArray(contentsOfFile: path)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = moviesInfos else {
            return 0
        }
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieSummaryCell
        let movieDic = moviesInfos[indexPath.row] as! [String : String]
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
    
    func setupSearchableContent() {
        var searchAbleItems = [CSSearchableItem]()
        
        moviesInfos.forEach { movieInfo in
            let movie = movieInfo as! [String : String]
            let searchAbleItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            searchAbleItemAttributeSet.title = movie["Title"]!
            
            let imagePathParts = movie["Image"]!.components(separatedBy: ".")
            searchAbleItemAttributeSet.thumbnailURL = Bundle.main.url(forResource: imagePathParts[0], withExtension: imagePathParts[1])
            
            searchAbleItemAttributeSet.contentDescription = movie["Description"]!
            
            var keywords = [String]()
            let movieCategorys = movie["Category"]!.components(separatedBy: ", ")
            movieCategorys.forEach({ category in
                keywords.append(category)
            })
            
            let stars = movie["Stars"]?.components(separatedBy: ", ")
            stars?.forEach({ star in
                keywords.append(star)
            })
            
            searchAbleItemAttributeSet.keywords = keywords
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "mx.dalySwift.Spotligh.\(moviesInfos.index(of: movieInfo))", domainIdentifier: "movies", attributeSet: searchAbleItemAttributeSet)
            searchAbleItems.append(searchableItem)
        }
        
        CSSearchableIndex.default().indexSearchableItems(searchAbleItems, completionHandler: { err in
            if let error = err {
                print(error.localizedDescription)
            }
        })

    }
}



