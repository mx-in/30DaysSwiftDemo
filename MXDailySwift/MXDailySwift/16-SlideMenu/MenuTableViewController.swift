//
//  ManuTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/15.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var menuItems = ["Everyday Moments", "Popular", "Editors", "Upcoming", "Fresh", "Stock-photos", "Trending"]
    var currentItem = "Everyday Moments"
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.backgroundColor = UIColor(red:0.109, green:0.114, blue:0.128, alpha:1)
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.itemLabel.text = menuItems[indexPath.row]
        cell.itemLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let manuTableViewControlle = segue.source as! MenuTableViewController
        
        if let selectedRow = manuTableViewControlle.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
        
    }
    
}
