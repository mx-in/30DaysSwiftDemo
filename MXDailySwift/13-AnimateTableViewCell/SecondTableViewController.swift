//
//  SecondTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/1.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class SecondTableViewController: ClearTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        let tableHeight = tableView.bounds.size.height
        
        for (index, cell) in tableView.visibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
}
