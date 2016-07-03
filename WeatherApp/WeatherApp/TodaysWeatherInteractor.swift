//
//  TodaysWeatherInteractor.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum JSONError: String, ErrorType {
    case NoData = "Error: No data to parse"
    case ParsingFailed = "Error: Could not parse data"
}

protocol TodaysWeatherInteractorOutput {
    func presentTodaysWeather(todaysWeather: TodaysWeather)
    func failedUpdatingTodaysWeather()
}

struct TodaysWeatherInteractor {
    var output: TodaysWeatherInteractorOutput!
    var client = HTTPClient()
}

extension TodaysWeatherInteractor: TodaysWeatherViewControllerOutput {
    
    func updateTodaysWeatherForLatitude(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = EndpointUtil.weatherTodayEndpointWithLatitude(latitude, longitude: longitude)
        if let url = NSURL(string: urlString) {
            
            client.get(url, completion: { (data, error) in
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] {
                        guard let todaysWeather = TodaysWeather(dictionary: json) else {
                            throw JSONError.ParsingFailed
                        }
                        self.output.presentTodaysWeather(todaysWeather)
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                    self.output.failedUpdatingTodaysWeather()
                } catch let error as NSError {
                    print(error.debugDescription)
                    self.output.failedUpdatingTodaysWeather()
                }
            })
        }
    }
}