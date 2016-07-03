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

protocol LocationDelegate: class {
    func updatedLocation(location: CLLocation)
}

class LocationManager: NSObject {
    let manager: CLLocationManager = CLLocationManager()
    weak var locationDelegate: LocationDelegate?
    
    var location: CLLocation? {
        return manager.location
    }
    
    override init() {
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 10
        manager.delegate = self
    }
    
    func startTrackingLocation() {
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.AuthorizedWhenInUse
            || status == CLAuthorizationStatus.AuthorizedAlways {
            manager.startUpdatingLocation()
        } else {
            showNoPermissionsAlert()
        }
    }
    
    func showNoPermissionsAlert() {
        
        guard let topController = UIApplication.sharedApplication().keyWindow?.rootViewController else {
            return
        }
        
        let alertController = UIAlertController(title: "No permission",
                                                message: "In order to work, the app needs your location", preferredStyle: .Alert)
        let openSettings = UIAlertAction(title: "Open settings", style: .Default, handler: {
            (action) -> Void in
            let URL = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(URL!)
        })
        alertController.addAction(openSettings)
        topController.presentViewController(alertController, animated: true, completion: nil)
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
            
            if let location = manager.location {
                locationDelegate?.updatedLocation(location)
            }
            break
        case .Restricted, .Denied:
            showNoPermissionsAlert()
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationDelegate?.updatedLocation(newLocation)
    }
}