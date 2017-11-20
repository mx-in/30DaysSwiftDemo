//
//  VideoCutter.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var convert: NSString { return (self as NSString) }
}

open class VideoCutter: NSObject {
    open func cropVideoWithURL(videoURL url: URL, startTime: CGFloat, duration: CGFloat, completion: ((_ videoPath: URL?, _ error: NSError?) -> Void)?) {
        let priority = DispatchQoS.QoSClass.default
        DispatchQueue.global(qos: priority).async {
            let asset = AVURLAsset(url: url)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths[0] as! String
            
            let manager = FileManager.default
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
            }
            
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            do {
                try manager.removeItem(atPath: outputURL)
            } catch _ {
            }
            
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, duration)
                
                exportSession.timeRange = range
                exportSession.exportAsynchronously(completionHandler: { 
                    switch exportSession.status {
                        case .completed:
                            completion?(exportSession.outputURL, nil)
                        case .failed:
                            completion?(nil, exportSession.error! as NSError)
                        case .cancelled:
                            completion?(nil, exportSession.error! as NSError)
                        default:
                            print("default case")
                    }
                })
            }
        }
    }
}
