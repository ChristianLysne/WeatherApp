//
//  CGFloatDegreesToRadiansTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CGFloatDegreesToRadiansTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testConvertDegreesToRadians() {
        
        let degrees: CGFloat = 180
        XCTAssertEqual(degrees.degreesToRadians, CGFloat(M_PI))
    }
    
    func testConvertRadiansToDegrees() {
        let radians: CGFloat = CGFloat(M_PI)
        XCTAssertEqual(radians.radiansToDegrees, 180)
    }
}
