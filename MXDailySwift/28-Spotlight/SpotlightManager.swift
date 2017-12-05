//
//  SpotlightManager.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/5.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreSpotlight

struct SpotlightManager {
    
    var moviesInfo: NSMutableArray? = nil
    
    let moviesDataPath: String? = {
        let resourceName = "MoviesData"
        let resourceType = "plist"
        
        return Bundle.main.path(forResource: resourceName, ofType: resourceType)
    }()
    
    init() {
        setupSpotlightData()
    }
    
    mutating func setupSpotlightData() {
        guard let filePath = moviesDataPath else {
            return
        }
        
        moviesInfo = NSMutableArray(contentsOfFile: filePath)
    }

    func movie(at index: Int) -> [String : String]? {
        guard let movies = moviesInfo else {
            return nil
        }
        
        return movies[index] as? [String : String]
    }
    
    let searchableItemIdentifierPrefix = "mx.dalySwift.Spotligh."
    let searchaalbeItemDomainIdentifier = "Movies"
    
    mutating func setupSearchableContent() {
        
        guard let movies = moviesInfo else {
            return
        }
        CSSearchableIndex.default().deleteAllSearchableItems { error in
            if let _ = error {
                print(error!.localizedDescription)
            }
        }
        
        var searchAbleItems = [CSSearchableItem]()
        movies.forEach { movieInfo in
            
            let searchAbleItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            let movie = movieInfo as! [String : String]
            let properties = itemProperties(from: movie)
            
            searchAbleItemAttributeSet.title = properties.title ?? ""
            searchAbleItemAttributeSet.thumbnailURL = properties.thumbnailURL
            searchAbleItemAttributeSet.contentDescription = properties.contentDescription ?? ""
            searchAbleItemAttributeSet.keywords = keywords(from: movie)
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "\(searchableItemIdentifierPrefix).\(movies.index(of: movieInfo))", domainIdentifier: searchaalbeItemDomainIdentifier, attributeSet: searchAbleItemAttributeSet)
            searchAbleItems.append(searchableItem)
        }
        
        CSSearchableIndex.default().indexSearchableItems(searchAbleItems, completionHandler: { error in
            if let _ = error {
                print(error!.localizedDescription)
            }
        })
        
    }
    
   fileprivate func keywords(from movieInfo: [String : String]) -> [String] {
        
        var keywords = [String]()
        let movieCategorys = movieInfo["Category"]!.components(separatedBy: ", ")
        movieCategorys.forEach({ category in
            keywords.append(category)
        })
        
        let stars = movieInfo["Stars"]?.components(separatedBy: ", ")
        stars?.forEach({ star in
            keywords.append(star)
        })
        
        return keywords
    }
    
    fileprivate func itemProperties(from movieInfo: [String : String]) -> (title: String?, thumbnailURL: URL?, contentDescription: String?) {
        
        let title = movieInfo["Title"]
        
        let imageParts = movieInfo["Image"]!.components(separatedBy: ".")
        let thumbnailURL = Bundle.main.url(forResource: imageParts.first, withExtension: imageParts.last)
        
        let contentDescription = movieInfo["Description"]
        
        return (title, thumbnailURL, contentDescription)
    }
    
}
