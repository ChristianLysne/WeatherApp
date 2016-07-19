//
//  StoredLocationsManager.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct StoredLocationsManager {
    
    static func getPresetLocations() -> [StoredLocation] {
        return ["Berlin", "London", "Dublin", "San Jose", "Portland"].map{StoredLocation(name: $0)}
    }
}