//
//  FirstViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/2.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var tableviewHeight: CGFloat {
        return articleTableView.bounds.height
    }
    
    let tableData = [
        
        Article(avatarImage: "allen", sharedName: "Allen Wang", actionType: "Read Later", articleTitle: "Giphy Cam Lets You Create And Share Homemade Gifs", articleCoverImage: "giphy", articleSource: "TheNextWeb", articleTime: "5min  •  13:20"),
        Article(avatarImage: "Daniel Hooper", sharedName: "Daniel Hooper", actionType: "Shared on Twitter", articleTitle: "Principle. The Sketch of Prototyping Tools", articleCoverImage: "my workflow flow", articleSource: "SketchTalk", articleTime: "3min  •  12:57"),
        
        Article(avatarImage: "davidbeckham", sharedName: "David Beckham", actionType: "Shared on Facebook", articleTitle: "Ohlala, An Uber For Escorts, Launches Its ‘Paid Dating’ Service In NYC", articleCoverImage: "Ohlala", articleSource: "TechCrunch", articleTime: "1min  •  12:59"),
        Article(avatarImage: "bruce", sharedName: "Bruce Fan", actionType: "Shared on Weibo", articleTitle: "Lonely Planet’s new mobile app helps you explore major cities like a pro", articleCoverImage: "Lonely Planet", articleSource: "36Kr", articleTime: "5min  •  11:21"),
        
        ]
    let reuseIdentifier = "ArticleTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.dataSource = self
        articleTableView.delegate = self
        articleTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        articleTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        articleTableView.reloadData()
        
        articleTableView.visibleCells.forEach { cell in
            cell.transform = CGAffineTransform(translationX: 0, y: tableviewHeight)
        }
        
        articleTableView.visibleCells.forEach { cell in
            UIView.animate(withDuration: 1.0,
                           delay: 0.05 * Double(articleTableView.visibleCells.index(of: cell)!),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        }
        
    }

}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleTableViewCell
        cell.prepareCell(tableData[indexPath.row])
        
        return cell
    }
    
    
}
