//
//  StoredLocationsTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class StoredLocationsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresetLocationsIsLoadedCorrectly() {

        let presetLocations = StoredLocationsManager.getPresetLocations()
        
        XCTAssertEqual(presetLocations.count, 5)
    }
}
