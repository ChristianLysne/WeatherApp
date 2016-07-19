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
    func updateTodaysWeather()
    func updateWeatherForLocation(location: StoredLocation)
}

enum UpdateWeatherState {
    case Loading
    case Error
    case DisplayWeather
}

class TodaysWeatherViewController: UIViewController {

    @IBOutlet weak var todaysWeatherView: TodaysWeatherView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorButton: ErrorButton!
    @IBOutlet weak var loadingView: LoadingView!
    
    var output: TodaysWeatherViewControllerOutput!
    var client = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewWithState(.Loading)
        TodaysWeatherConfigurator.sharedInstance.configure(self, client: client)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func errorButtonTapped(sender: AnyObject) {
        if let errorButton = sender as? ErrorButton, error = errorButton.error {
            switch error {
            case .FailedToLoadData:
                updateViewWithState(.Loading)
                output.updateTodaysWeather()
            case .LocationNotFound:
                break;
            case .NoPermission:
                let URL = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(URL!)
            }
        }
    }
    
    func updateViewWithState(state: UpdateWeatherState) {
        state == .Loading ? loadingView.startAnimating() : loadingView.stopAnimating()
        
        self.loadingView.hidden = state != .Loading
        
        UIView.animateWithDuration(1.0) {
            self.errorView.alpha = state == .Error ? 1 : 0
            self.todaysWeatherView.alpha = state == .DisplayWeather ? 1 : 0
        }
    }
    
    @IBAction func changeLocationButtonTapped(sender: AnyObject) {
        
        let locationsViewController = storyboard?.instantiateViewControllerWithIdentifier("LocationsViewController") as! LocationsViewController
        locationsViewController.locationChangedDelegate = self
        self.navigationController?.pushViewController(locationsViewController, animated: true)
    }
}

extension TodaysWeatherViewController: TodaysWeatherPresenterOutput {
    func displayTodaysWeather(viewModel: TodaysWeatherViewModel) {
        dispatch_async(dispatch_get_main_queue()) {
            self.todaysWeatherView.configureViewWithViewModel(viewModel)
            self.updateViewWithState(.DisplayWeather)
        }
    }
    
    func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString, buttonText: String?, error: UpdateWeatherError) {
        dispatch_async(dispatch_get_main_queue()) {
            
            self.updateViewWithState(.Error)
            self.errorLabel.attributedText = errorMessage
            
            self.errorButton.error = error
            if let buttonText = buttonText {
                self.errorButton.setTitle(buttonText, forState: .Normal)
                self.errorButton.hidden = false
            } else {
                self.errorButton.hidden = true
            }
        }
    }
}

extension TodaysWeatherViewController: LocationChangedDelegate {
    func locationChanged(location: StoredLocation) {
        output.updateWeatherForLocation(location)
    }
}

