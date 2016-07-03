//
//  TodaysWeatherViewTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class TodaysWeatherViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfigureTodaysWeatherView() {
        
        let todaysWeather = TodaysWeather(id: 1,
                                          locationName: "LocationName",
                                          icon: "01d",
                                          temp: 50,
                                          tempMin: 50,
                                          tempMax: 50,
                                          windSpeed: 50,
                                          windDegrees: 50,
                                          rainInMM: 50,
                                          time: NSDate())
        let todaysWeatherViewModel = TodaysWeatherViewModel(todaysWeather: todaysWeather)
        
        
        let todaysWeatherView = TodaysWeatherView()
        todaysWeatherView.configureViewWithViewModel(todaysWeatherViewModel)
        
        XCTAssertEqual(todaysWeatherView.temperatureLabel.attributedText, todaysWeatherViewModel.temperatureAttributedString)
        XCTAssertEqual(todaysWeatherView.weatherImageView.image, todaysWeatherViewModel.weatherIconImage)
    }
}