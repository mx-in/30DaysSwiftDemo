//
//  ViewController.swift
//  MXDailySwift
//
//  Created by mx_in on 16/12/16.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class ProjViewController: UITableViewController {
    
    let projCellIdentify = "projectCellIdentify"
    let projects = ["StopWatch", "CarouselEffect", "PullToRefresh", "RandomColorization", "ImageScrollerEffect", "VideoBackground", "ClearTableViewController", "LoginAnimation", "AnimationTable", "EmojiMachine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: projCellIdentify)
        self.title = "🌻SwiftDaily😁"
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: projCellIdentify)! as UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row + 1) - \(projects[indexPath.row])"
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: projects[indexPath.row], sender: self)
    }
    
}


