//
//  ViewController.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import UIKit
import CoreLocation

protocol TodaysWeatherViewControllerOutput {
    func updateTodaysWeatherForLatitude(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class TodaysWeatherViewController: UIViewController {

    @IBOutlet weak var todaysWeatherView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureMaxInfoLabelWithIconView: InfoLabelAndIconView!
    @IBOutlet weak var temperatureMinInfoLabelAndIconView: InfoLabelAndIconView!
    @IBOutlet weak var windInfoLabelAndIconView: InfoLabelAndIconView!
    @IBOutlet weak var rainInfoLabelAndIconView: InfoLabelAndIconView!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var output: TodaysWeatherViewControllerOutput!
    var client = HTTPClient()
    var locationManager = LocationManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TodaysWeatherConfigurator.sharedInstance.configure(self, client: client)
        
        locationManager.locationDelegate = self
        locationManager.startTrackingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                
        tryAgainButton.layer.cornerRadius = 5
        tryAgainButton.layer.borderColor = Constants.Colors.TodaysWeatherInfo.CGColor
        tryAgainButton.layer.borderWidth = 1
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func tryAgainButtonTapped(sender: AnyObject) {
        if let location = locationManager.location {
            output.updateTodaysWeatherForLatitude(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}

extension TodaysWeatherViewController: TodaysWeatherPresenterOutput {
    func displayTodaysWeather(viewModel: TodaysWeatherViewModel) {
        dispatch_async(dispatch_get_main_queue()) {
            self.todaysWeatherView.hidden = false
            self.errorView.hidden = true
            self.locationLabel.attributedText = viewModel.locationAttributedString
            self.temperatureLabel.attributedText = viewModel.temperatureAttributedString
            self.temperatureMaxInfoLabelWithIconView.configureWithInfoTextAndIcon(viewModel.temperatureMaxInfoTextAndIcon,
                                                                                  tintColor: Constants.Colors.TodaysWeatherInfo)
            self.temperatureMinInfoLabelAndIconView.configureWithInfoTextAndIcon(viewModel.temperatureMinInfoTextAndIcon,
                                                                                 tintColor: Constants.Colors.TodaysWeatherInfo)
            self.windInfoLabelAndIconView.configureWithInfoTextAndIcon(viewModel.windSpeedInfoTextAndIcon,
                                                                       tintColor: Constants.Colors.TodaysWeatherInfo)
            self.rainInfoLabelAndIconView.configureWithInfoTextAndIcon(viewModel.rainInfoTextAndIcon,
                                                                       tintColor: Constants.Colors.TodaysWeatherInfo)
            if let imageURL = viewModel.weatherIconImageURL {
                self.weatherImageView.setImageFromURL(imageURL)
            }
        }
    }
    
    func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString) {
        dispatch_async(dispatch_get_main_queue()) {
            self.todaysWeatherView.hidden = true
            self.errorView.hidden = false
            self.errorLabel.attributedText = errorMessage
        }
    }
}

extension TodaysWeatherViewController: LocationDelegate {
    func updatedLocation(location: CLLocation) {
        output.updateTodaysWeatherForLatitude(location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

