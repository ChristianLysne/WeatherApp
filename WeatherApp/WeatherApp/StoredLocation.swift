//
//  StoredLocation.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class StoredLocation: NSObject {
    
    var coordinate: CLLocationCoordinate2D?
    var name: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        super.init()
        self.coordinate = coordinate
    }
    
    init(name: String) {
        super.init()
        self.name = name
    }
}