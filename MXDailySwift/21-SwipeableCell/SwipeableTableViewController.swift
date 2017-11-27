//
//  SwipeableTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/27.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class SwipeableTableViewController: UITableViewController {
    
    fileprivate var data = [
        Pattern(image: "21-1", name: "Pattern Building"),
        Pattern(image: "21-2", name: "Joe Beez"),
        Pattern(image: "21-3", name: "Car It's car"),
        Pattern(image: "21-4", name: "Floral Kaleidoscopic"),
        Pattern(image: "21-5", name: "Sprinkle Pattern"),
        Pattern(image: "21-6", name: "Palitos de queso"),
        Pattern(image: "21-7", name: "Ready to Go? Pattern"),
        Pattern(image: "21-8", name: "Sets Seamless"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PatternCell.self), for: indexPath) as? PatternCell
        
        guard let patternCell = cell else {
            return UITableViewCell()
        }
        
        let pattern = data[indexPath.row]
        patternCell.prepareCell(pattern)

        return patternCell
     }
    
    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "🗑\nDelete", handler: { action, index in
            print("delete button tapped")
        })
        
        let share = UITableViewRowAction(style: .normal, title: "🤗\nShare", handler: { (action: UITableViewRowAction, indexPath: IndexPath) in
            
            let firstActiveItem = self.data[indexPath.row]
            let activeViewController =  UIActivityViewController(activityItems: [firstActiveItem.image as NSString], applicationActivities: nil)
            self.present(activeViewController, animated: true, completion: nil)
            })
        share.backgroundColor = .red
        
        let download = UITableViewRowAction(style: .normal, title: "⬇️\nDownload", handler: { (action, index) in
                print("download button tapped")
            })
        download.backgroundColor = .blue
        
        return [delete, share, download]
        
    }
}
