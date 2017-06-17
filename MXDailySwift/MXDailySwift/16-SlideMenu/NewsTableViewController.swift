//
//  NewsViewControllerTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, MenuTransitionManagerDelegate {
    
    let menuTransitionManager = MenuTransitionManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Everyday Moments"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.backgroundColor = UIColor(red:0.062, green:0.062, blue:0.07, alpha:1)
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //    MARK: - MenuTransitionManagerDelegate
    func dissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        cell.backgroundColor = .clear
        
        if indexPath.row == 0 {
            let image = UIImage(named: "1")
            cell.postImageView.image = image
            cell.postTitle.text = "Love mountain."
            cell.postAuthor.text = "Allen Wang"
            cell.postAuthorImageView.image = UIImage(named: "a")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "2")
            cell.postTitle.text = "New graphic design - LIVE FREE"
            cell.postAuthor.text = "Cole"
            cell.postAuthorImageView.image = UIImage(named: "b")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "3")
            cell.postTitle.text = "Summer sand"
            cell.postAuthor.text = "Daniel Hooper"
            cell.postAuthorImageView.image = UIImage(named: "c")
            
        } else {
            cell.postImageView.image = UIImage(named: "4")
            cell.postTitle.text = "Seeking for signal"
            cell.postAuthor.text = "Noby-Wan Kenobi"
            cell.postAuthorImageView.image = UIImage(named: "d")
            
        }
        
        return cell
        
    }
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        let sourceController = segue.source as! MenuTableViewController
        self.title = sourceController.currentItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuViewController = segue.destination as! MenuTableViewController
        menuViewController.currentItem = self.title!
        menuViewController.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
    }
}
