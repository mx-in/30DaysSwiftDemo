//
//  ClearTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/30.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ClearTableViewController: UITableViewController {

    var tableData = ["Read 3 article on Medium", "Cleanup bedroom", "Go for a run", "Hit the gym", "Build another swift project", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
        
        self.view.backgroundColor = UIColor.black
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.register(ClearTableViewCell.self, forCellReuseIdentifier: "ClearTableViewCell")
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClearTableViewCell", for: indexPath)

        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(indexPath.row)
    }
    
    func colorForIndex(_ index: Int) -> UIColor {
        
        let itemCount = tableData.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        
        return UIColor (red: 1.0, green: color, blue: 1.0, alpha: 1.0)
    }
}
