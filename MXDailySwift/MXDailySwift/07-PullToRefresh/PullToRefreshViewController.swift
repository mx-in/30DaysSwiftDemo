//
//  PullToRefreshViewController.swift
//  MXDailySwift
//
//  Created by mx_in on 16/12/16.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class PullToRefreshViewController: UIViewController, UITableViewDataSource {

    let cellIdentifer = "NewCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    var emojiData = [String]()
    
    var tableViewController = UITableViewController(style: .plain)
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiData = favoriteEmoji
        let emojiTableView = tableViewController.tableView
        
        emojiTableView?.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        emojiTableView?.dataSource = self;
        emojiTableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(PullToRefreshViewController.didReloadEmoji), for: .valueChanged)
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        
        let attribute = [NSForegroundColorAttributeName : UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Last Updated on \(Date())", attributes: attribute)
        refreshControl.tintColor = UIColor.white
        
        self.title = "emoji"
        
//        lt row height is changed to the value set in Interface Builder. To get the expected self-sizing behavior for a cell that you create in Interface Builder, you must explicitly set rowHeight equal to UITableViewAutomaticDimension in your code.
        emojiTableView?.rowHeight = UITableViewAutomaticDimension
        
//        Providing a nonnegative estimate of the height of rows can improve the performance of loading the table view. If the table contains variable height rows
        emojiTableView?.estimatedRowHeight = 60.0
        emojiTableView?.tableFooterView = UIView(frame: CGRect.zero)
        emojiTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.view.addSubview(emojiTableView!)
    }
    
    func didReloadEmoji() {
        emojiData = newFavoriteEmoji
        tableViewController.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
//MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        cell.textLabel?.text = emojiData[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
}
