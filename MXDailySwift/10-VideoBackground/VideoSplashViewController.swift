//
//  VideoSplashViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

public enum ScalingModel {
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashViewController: UIViewController {

fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel: Float = 1.0
    open var contentURL: URL! {
        didSet{
            setMoviePlayer(contentURL)
        }
    }
    
    open var videoFrame: CGRect = CGRect()
    open var startTime: CGFloat = 0.0
    open var duration: CGFloat = 0.0
    open var backgroundColor: UIColor = UIColor.black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    open var sound: Bool = true {
        didSet {
            if sound {
                moviePlayerSoundLevel = 1.0
            } else {
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    
    open var alpha: CGFloat = CGFloat() {
        didSet {
            moviePlayer.view.alpha = alpha
        }
    }
    
    open var alwaysRepeat = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime
                    , object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    open var fillMode: ScalingModel = .resizeAspectFill {
        didSet {
            switch fillMode {
            case .resize:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case .resizeAspectFill:
                moviePlayer.videoGravity = AVVideoScalingModeResizeAspectFill
            case .resizeAspect:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubview(toBack: moviePlayer.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime)
    }
    
    fileprivate func setMoviePlayer(_ url: URL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithURL(videoURL: url, startTime: startTime, duration: duration) { (videoPath, error) in
            if let path = videoPath {
                self.moviePlayer.player = AVPlayer(url: path)
                self.moviePlayer.player?.play()
                self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
            }
        }
    }
    
    func playerItemDidReachEnd() {
        moviePlayer.player?.seek(to: kCMTimeZero)
        moviePlayer.player?.play()
    }
    
}
