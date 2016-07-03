//
//  EndpointUtilTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class EndpointUtilTests: XCTestCase {

    func testEndpointUtilReturnsExpectedString() {
        
        let expectedString = "http://api.openweathermap.org/data/2.5/weather?lat=51.508369&lon=-0.176125&units=metric&APPID=8745c4d5464ba76d6ad1dbc2442cb51e"
        
        let latitude: CLLocationDegrees = 51.508369
        let longitude: CLLocationDegrees = -0.176125
        
        let endpointString = EndpointUtil.weatherTodayEndpointWithLatitude(latitude, longitude: longitude)
        
        XCTAssertEqual(expectedString, endpointString)
    }
}
