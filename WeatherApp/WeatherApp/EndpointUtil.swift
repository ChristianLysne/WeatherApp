//
//  EndpointUtil.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct EndpointUtil {
    static func weatherTodayEndpointWithLatitude(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        return "\(Constants.Endpoints.WeatherToday)lat=\(latitude)&lon=\(longitude)&units=metric&APPID=\(Constants.APIKeys.OpenWeatherMap)"
    }
    
    static func weatherTodayEndpointWithName(name: String) -> String {
        return "\(Constants.Endpoints.WeatherToday)q=\(name)&units=metric&APPID=\(Constants.APIKeys.OpenWeatherMap)"
    }
}