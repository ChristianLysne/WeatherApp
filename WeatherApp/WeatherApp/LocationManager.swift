//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

enum LocationError {
    case PermissionDenied
    case LocationNotFound
}

protocol LocationDelegate: class {
    func updatedLocation()
    func couldNotFindLocationWithErrorCode(errorCode: LocationError)
}

protocol Location {
    weak var locationDelegate: LocationDelegate? { get set }
    func location() -> CLLocation?
    func startTrackingLocation()
}

class LocationManager: NSObject {
    let manager: CLLocationManager = CLLocationManager()
    weak var locationDelegate: LocationDelegate?

    override init() {
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 10
        manager.delegate = self
    }
}

extension LocationManager: Location {
    func location() -> CLLocation? {
        return manager.location
    }
    
    func startTrackingLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.AuthorizedWhenInUse
            || status == CLAuthorizationStatus.AuthorizedAlways {
            manager.startUpdatingLocation()
        } else {
            locationDelegate?.couldNotFindLocationWithErrorCode(.PermissionDenied)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            manager.startUpdatingLocation()
            
            if let _ = manager.location {
                locationDelegate?.updatedLocation()
            } else {
                locationDelegate?.couldNotFindLocationWithErrorCode(.LocationNotFound)
            }
            break
        case .Restricted, .Denied:
            locationDelegate?.couldNotFindLocationWithErrorCode(.PermissionDenied)
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationDelegate?.updatedLocation()
    }
}