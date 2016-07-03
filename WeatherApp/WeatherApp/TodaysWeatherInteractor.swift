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

enum UpdateWeatherError {
    case FailedToLoadData
    case NoPermission
    case LocationNotFound
}

protocol TodaysWeatherInteractorOutput {
    func presentTodaysWeather(todaysWeather: TodaysWeather)
    func failedUpdatingTodaysWeatherWithError(error: UpdateWeatherError)
}

class TodaysWeatherInteractor {
    var output: TodaysWeatherInteractorOutput!
    var client = HTTPClient()
    var locationManager: Location = LocationManager()
    
    func startTrackingLocation() {
        if UITesting() {
            // Return data from mocked location in launch arguments
            getTodaysWeatherFromURL(NSURL())
            return
        }
        
        locationManager.locationDelegate = self
        locationManager.startTrackingLocation()
    }
    
    private func getTodaysWeatherFromURL(url: NSURL) {
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
                self.output.failedUpdatingTodaysWeatherWithError(.FailedToLoadData)
            } catch let error as NSError {
                print(error.debugDescription)
                self.output.failedUpdatingTodaysWeatherWithError(.FailedToLoadData)
            }
        })
    }
}

extension TodaysWeatherInteractor: TodaysWeatherViewControllerOutput {
    
    func updateTodaysWeather() {
        guard let location = locationManager.location() else {
            output.failedUpdatingTodaysWeatherWithError(.LocationNotFound)
            return
        }
        
        let urlString = EndpointUtil.weatherTodayEndpointWithLatitude(location.coordinate.latitude, longitude: location.coordinate.longitude)
        if let url = NSURL(string: urlString) {
            getTodaysWeatherFromURL(url)
        }
    }
}

extension TodaysWeatherInteractor: LocationDelegate {
    
    func updatedLocation() {
        updateTodaysWeather()
    }
    
    func couldNotFindLocationWithErrorCode(errorCode: LocationError) {
        switch errorCode {
        case .LocationNotFound:
            output.failedUpdatingTodaysWeatherWithError(.LocationNotFound)
        case .PermissionDenied:
            output.failedUpdatingTodaysWeatherWithError(.NoPermission)
        }
    }
}