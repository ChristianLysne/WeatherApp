//
//  ViewController.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import UIKit

protocol TodaysWeatherViewControllerOutput {
    func updateTodaysWeatherForLatitude(latitude: CGFloat, longitude: CGFloat)
}

class TodaysWeatherViewController: UIViewController {

    var output: TodaysWeatherViewControllerOutput!
    var client = HTTPClient()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TodaysWeatherConfigurator.sharedInstance.configure(self, client: client)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude: CGFloat = 51.508369
        let longitude: CGFloat = -0.176125
        output.updateTodaysWeatherForLatitude(latitude, longitude: longitude)
    }
}

extension TodaysWeatherViewController: TodaysWeatherPresenterOutput {
    func displayTodaysWeather(viewModel: TodaysWeatherViewModel) {
        print("displayTodaysWeather")
    }
    
    func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString) {
        print("failedUpdatingTodaysWeatherWithErrorMessage")
    }
}

