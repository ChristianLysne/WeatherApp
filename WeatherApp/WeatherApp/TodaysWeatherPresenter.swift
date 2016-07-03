//
//  TodaysWeatherPresenter.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

protocol TodaysWeatherPresenterOutput: class {
    func displayTodaysWeather(todaysWeatherViewModel: TodaysWeatherViewModel)
    func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString, buttonText: String?, error: UpdateWeatherError)
}

struct TodaysWeatherPresenter {
    
    weak var output: TodaysWeatherPresenterOutput!
}

extension TodaysWeatherPresenter: TodaysWeatherInteractorOutput {
    func presentTodaysWeather(todaysWeather: TodaysWeather) {
        let viewModel = TodaysWeatherViewModel(todaysWeather: todaysWeather)
        output.displayTodaysWeather(viewModel)
    }
    
    func failedUpdatingTodaysWeatherWithError(error: UpdateWeatherError) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        let attributes = [NSForegroundColorAttributeName: Constants.Colors.TodaysWeatherInfo,
                          NSFontAttributeName : UIFont.systemFontOfSize(40.0),
                          NSParagraphStyleAttributeName: style]
        let errorMessageString: String
        var buttonText: String?
        
        switch error {
        case .FailedToLoadData:
            errorMessageString = "Failed to update todays weather 😞"
            buttonText = "Try again"
        case .LocationNotFound:
            errorMessageString = "Location not found 😞"
        case .NoPermission:
            errorMessageString = "You have not given permission to access location 😞"
            buttonText = "Go to settings"
        }
        
        let errorMessage = NSAttributedString(string: errorMessageString, attributes: attributes)
        output.failedUpdatingTodaysWeatherWithErrorMessage(errorMessage, buttonText: buttonText, error: error)
    }
}