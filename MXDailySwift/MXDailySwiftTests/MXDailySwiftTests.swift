//
//  MXDailySwiftTests.swift
//  MXDailySwiftTests
//
//  Created by mx_in on 16/12/16.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import XCTest
@testable import DailySwift

class DailySwiftTests: XCTestCase {
    
    var funyUndreTest: funny!
    
    override func setUp() {
//        super.setUp()
        funyUndreTest = funny(title: "hello", description: "test Description", featuredImage: UIImage(named: "steve")!)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        funyUndreTest = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
