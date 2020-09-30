//
//  CPRefreshViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/21.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class CPRefreshViewController: UIViewController {

    let dataSourceArray: Array<String> = ["😂", "🤗", "😳", "😌", "😊"]
    let colorsArray: [UIColor] = [.magenta, .brown, .yellow, .red, .green, .blue, .orange]
    let animateTime = 5.0
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl = UIRefreshControl() {
        didSet {
            oldValue.tintColor = UIColor.clear
            oldValue.backgroundColor = UIColor.clear
        }
    }

    var timer: Timer!
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    var customRefreshView: UIView!
    var lablesArr: [UILabel] = []

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.addSubview(refreshControl)
        
        loadCustomRefreshContents()
    }
    
    func loadCustomRefreshContents() {
        
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        customRefreshView = refreshContents![0] as? UIView
        customRefreshView.frame = refreshControl.bounds
        
        _ = customRefreshView.subviews.map { subView in
            let viewTag = customRefreshView.subviews.firstIndex(of: subView)! + 1
            lablesArr.append(customRefreshView.viewWithTag(viewTag) as! UILabel)
        }
        refreshControl.addSubview(customRefreshView)
    }
    
}

//MARK: -Animate Step
extension CPRefreshViewController {
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
           
            self.lablesArr[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4.0))
            self.lablesArr[self.currentLabelIndex].textColor = self.getNextColor()
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: {
                self.lablesArr[self.currentLabelIndex].transform = .identity
                self.lablesArr[self.currentLabelIndex].textColor = .black
            }, completion: { (finished) in
                self.currentLabelIndex += 1
                
                if self.currentLabelIndex < self.lablesArr.count {
                    self.animateRefreshStep1()
                } else {
                    self.animateRefreshStep2()
                }
            })
        }
    }
    
    func getNextColor() -> UIColor {
        
        guard currentColorIndex < self.colorsArray.count else {
            currentColorIndex = 0
            return self.colorsArray[currentColorIndex]
        }
        
        let returnedColor = self.colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnedColor
    }
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
            _ = self.lablesArr.map {
                $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }) { (finished) in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                _ = self.lablesArr.map {
                    $0.transform = .identity
                }
            }, completion: { (finished) in
                if self.refreshControl.isRefreshing {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                } else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                }
            })
        }
    }
}

//MARK: -Delegate
extension CPRefreshViewController:  UITableViewDelegate, UITableViewDataSource   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CPRCell", for: indexPath)
        
        cell.textLabel?.text = self.dataSourceArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 40.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            if !isAnimating {
                startEndCountdown()
                animateRefreshStep1()
            }
        }
    }
    
    func startEndCountdown(){
        timer = Timer.scheduledTimer(timeInterval: self.animateTime, target: self, selector: #selector(endOfAnimate), userInfo: nil, repeats: true)
    }
    
    @objc func endOfAnimate() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }
}
