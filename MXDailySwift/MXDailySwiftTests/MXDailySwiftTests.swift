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
    
    func testFunny() {
        
        funyUndreTest.numberOfMembers += 5;
        
        XCTAssertEqual(funyUndreTest.numberOfMembers, 10, "test for numberOfMembers")
    }
    
}
