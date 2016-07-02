//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        app.launchArguments += ["UITesting"]
        
        let latitude: CGFloat = 51.508369
        let longitude: CGFloat = -0.176125
        
        // Replace = with EQUALS to use in launchEnvironment
        let baysWaterURL = EndpointUtil.weatherTodayEndpointWithLatitude(latitude, longitude: longitude).stringByReplacingOccurrencesOfString("=", withString: "EQUALS")
        
        let uitestHelper = UITestHelper()
        app.launchEnvironment[baysWaterURL] = uitestHelper.readJSONFromFile("BayswaterExample")
        
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
}
