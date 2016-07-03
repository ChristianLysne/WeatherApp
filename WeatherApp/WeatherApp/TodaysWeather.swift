//
//  TodaysWeather.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct TodaysWeather {
    let id: Int
    let locationName: String
    let icon: String
    let temp: Float
    let tempMin: Float
    let tempMax: Float
    let windSpeed: Float
    let windDegrees: Float
    let rainInMM: Float?
    let time: NSDate
    
    init(id: Int,
         locationName: String,
         icon: String,
         temp: Float,
         tempMin: Float,
         tempMax: Float,
         windSpeed: Float,
         windDegrees: Float,
         rainInMM: Float?,
         time: NSDate) {
        self.id = id
        self.locationName = locationName
        self.icon = icon
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.windSpeed = windSpeed
        self.windDegrees = windDegrees
        self.rainInMM = rainInMM
        self.time = time
    }
    
    init?(dictionary: [String: AnyObject]) {
        
        let id = dictionary["weather"]?[0]["id"] as? Int
        let locationName = dictionary["name"] as? String
        let icon = dictionary["weather"]?[0]["icon"] as? String
        let temp = dictionary["main"]?["temp"] as? Float
        let tempMin = dictionary["main"]?["temp_min"] as? Float
        let tempMax = dictionary["main"]?["temp_max"] as? Float
        let windSpeed = dictionary["wind"]?["speed"] as? Float
        let windDegrees = dictionary["wind"]?["deg"] as? Float

        let rainInMM = dictionary["rain"]?["3h"] as? Float
        let timeInUnix = dictionary["dt"] as? Double
        
        if let id = id,
            locationName = locationName,
            icon = icon,
            temp = temp,
            tempMin = tempMin,
            tempMax = tempMax,
            windSpeed = windSpeed,
            windDegrees = windDegrees,
            timeInUnix = timeInUnix {
            
            let time = NSDate(timeIntervalSince1970: timeInUnix)
            
            self.init(id: id,
                      locationName: locationName,
                      icon: icon,
                      temp: temp,
                      tempMin: tempMin,
                      tempMax: tempMax,
                      windSpeed: windSpeed,
                      windDegrees: windDegrees,
                      rainInMM: rainInMM,
                      time: time)
        } else {
            return nil
        }
    }
}