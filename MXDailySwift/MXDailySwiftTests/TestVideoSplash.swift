//
//  TestVideoSplash.swift
//  DailySwift
//
//  Created by mx_in on 2017/5/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import XCTest

@testable import DailySwift

class TestVideoSplash: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testVideoCutter() {
        
        let videoCutter = VideoCutter()
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        
        let promise = expectation(description: "cut video success")
        
        videoCutter.cropVideoWithURL(
            videoURL: url,
            startTime: 11.0,
            duration: 1.0) { (videoPath, error) -> Void in
                        XCTAssertNotNil(videoPath, "video cut has failed")
                        promise.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
