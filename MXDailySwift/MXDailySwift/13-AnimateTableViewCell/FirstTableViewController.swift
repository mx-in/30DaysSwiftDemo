//
//  FirstTableViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/6/1.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class FirstTableViewController: ClearTableViewController {

    override var tableData: [String] {
        set {
            print(newValue)
        }
        get {
            return ["Personal Life", "Buddy Company", "#30 days Swift Project", "Body movement training", "AppKitchen Studio", "Project Read", "Others" ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellBackgroundForIndex = { index in
            let itemCount = self.tableData.count - 1
            let green = (CGFloat(index) / CGFloat(itemCount)) * 0.6
            return UIColor(red: 0.0, green: green, blue: 1.0, alpha: 1.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        for i in 0..<cells.count {
            
            cells[i].transform = CGAffineTransform(translationX: 0, y: tableHeight/2)
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(i), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                
                    cells[i].transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SecondViewController", sender: nil)
    }

}
