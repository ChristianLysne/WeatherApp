//
//  Constants.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct APIKeys {
        static let OpenWeatherMap = "8745c4d5464ba76d6ad1dbc2442cb51e"
    }
    
    struct Endpoints {
        static let WeatherToday = "http://api.openweathermap.org/data/2.5/weather?"
        static let WeatherIcon = "http://openweathermap.org/img/w/"
    }
    
    struct Colors {
        static let Green = UIColor(red: 67/255, green: 206/255, blue: 162/255, alpha: 1)
        static let Blue = UIColor(red: 24/255, green: 90/255, blue: 157/255, alpha: 1)
        static let TodaysWeatherInfo = UIColor.whiteColor()
    }
}