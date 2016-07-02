//
//  ConfigTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ConfigTests: XCTestCase {
    
    func testConfigReturnsCorrectEnvironment() {
        XCTAssertEqual(Config.urlSession, NSURLSession.sharedSession())
    }
}
