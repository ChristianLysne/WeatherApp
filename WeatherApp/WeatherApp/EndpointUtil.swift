//
//  EndpointUtil.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

struct EndpointUtil {
    static func weatherTodayEndpointWithLatitude(latitude: CGFloat, longitude: CGFloat) -> String {
        return "\(Constants.Endpoints.WeatherToday)lat=\(latitude)&lon=\(longitude)&APPID=\(Constants.APIKeys.OpenWeatherMap)"
    }
}