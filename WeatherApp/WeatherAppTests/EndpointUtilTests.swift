//
//  EndpointUtilTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class EndpointUtilTests: XCTestCase {

    func testEndpointUtilReturnsExpectedString() {
        
        let expectedString = "http://api.openweathermap.org/data/2.5/weather?lat=51.508369&lon=-0.176125&APPID=8745c4d5464ba76d6ad1dbc2442cb51e"
        
        let latitude: CGFloat = 51.508369
        let longitude: CGFloat = -0.176125
        
        let endpointString = EndpointUtil.weatherTodayEndpointWithLatitude(latitude, longitude: longitude)
        
        XCTAssertEqual(expectedString, endpointString)
    }
}
