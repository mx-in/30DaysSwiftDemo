//
//  ViewController.swift
//  MXStopWatch
//
//  Created by mx_in on 16/11/29.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class StopViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    
    
    var counter = 0.0
    var timer = Foundation.Timer()
    var isPlaying = false
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        print(counter)
        timeLabel.text = String(counter)
        super.viewDidLoad()
        
    }
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBAction func playBtnOntouch(_ sender: UIButton) {
        if isPlaying {
            return
        }
        
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Foundation.Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(StopViewController.updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }

    @IBAction func pauseBtnOntouch(_ sender: UIButton) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        isPlaying = false
    }

    @IBAction func resetBtnOntouch(_ sender: UIButton) {
        timer.invalidate()
        isPlaying = false
        counter = 0
        timeLabel.text = String(counter)
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
    }
    
    func updateTimer(){
        counter += 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
}

