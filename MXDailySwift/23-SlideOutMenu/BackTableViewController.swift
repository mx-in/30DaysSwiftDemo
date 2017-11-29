//
//  BackTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class BackTableViewController: UITableViewController {

    let tableData = ["FriendRead", "Article", "ReadLater"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red:0.159, green:0.156, blue:0.181, alpha:1)
        self.view.backgroundColor = .black

    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableData[indexPath.row], for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        selCell.contentView.backgroundColor = UIColor(red:0.245, green:0.247, blue:0.272, alpha:0.817)
        
    }


}
