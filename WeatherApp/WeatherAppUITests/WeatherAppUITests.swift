//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
import CoreLocation

class WeatherAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        app.launchArguments.append("UITesting")
        
        let testHelper = TestHelper()
        app.launchEnvironment["UITesting-URL"] = testHelper.readJSONFromFile("BayswaterExample")
        
        continueAfterFailure = false
        app.launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllDataInTodaysWeatherViewIsDisplayedCorrectly() {
        
        // Used tap() instead of waitForExpectationsWithTimeout, as 
        // this will also let the OS dismiss the location alert if it appears
        app.staticTexts["Bayswater"].tap()
        
        XCTAssertTrue(app.staticTexts["Bayswater"].exists)
        XCTAssertTrue(app.staticTexts["290.66°"].exists)
        XCTAssertTrue(app.images["10d"].exists)
        XCTAssertTrue(app.images["ArrowUp"].exists)
        XCTAssertTrue(app.images["ArrowDown"].exists)
        XCTAssertTrue(app.images["ArrowWind"].exists)
        XCTAssertTrue(app.images["RainDrop"].exists)
        XCTAssertTrue(app.staticTexts["292.59°"].exists)
        XCTAssertTrue(app.staticTexts["289.15°"].exists)
        XCTAssertTrue(app.staticTexts["7.2 mps"].exists)
        XCTAssertTrue(app.staticTexts["0.0 mm"].exists)
    }
}
