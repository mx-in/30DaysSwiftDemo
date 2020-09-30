//
//  RandomColorizationVC.swift
//  DailySwift
//
//  Created by mx_in on 16/12/18.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit
import AVFoundation

class RandomColorizationVC: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    let gradientLayer = CAGradientLayer()
    
    var time: Timer?

    @IBAction func playMusicBtnDidTouched(_ sender: UIButton) {
        let bgMusic = URL(string: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: bgMusic!)
            
            guard let player = audioPlayer else {
                return
            }
            player.prepareToPlay()
            player.play()
            
        } catch let audioError as NSError {
            print(audioError)
        }
        
        if time == nil {
            time = Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(RandomColorizationVC.randomColor), userInfo: nil, repeats: true)
        }
        
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueVaule = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueVaule, alpha: 1.0)
        
        gradientLayer.frame = self.view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y:0);
        gradientLayer.endPoint = CGPoint(x: 1, y: 1);
        
        self.view.layer.addSublayer(gradientLayer)
        
    }
    
    @objc func randomColor() {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueVaule = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueVaule, alpha: 1.0)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let player = audioPlayer else {
            return
        }
        
        player.pause()
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
