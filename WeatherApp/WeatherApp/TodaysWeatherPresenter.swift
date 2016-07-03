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
    func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString)
}

struct TodaysWeatherPresenter {
    
    weak var output: TodaysWeatherPresenterOutput!
}

extension TodaysWeatherPresenter: TodaysWeatherInteractorOutput {
    func presentTodaysWeather(todaysWeather: TodaysWeather) {
        let viewModel = TodaysWeatherViewModel(todaysWeather: todaysWeather)
        output.displayTodaysWeather(viewModel)
    }
    
    func failedUpdatingTodaysWeather() {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        let attributes = [NSForegroundColorAttributeName: Constants.Colors.TodaysWeatherInfo,
                          NSFontAttributeName : UIFont.systemFontOfSize(50.0),
                          NSParagraphStyleAttributeName: style]
        let errorMessage = NSAttributedString(string: "Failed to update todays weather 😞", attributes: attributes)
        output.failedUpdatingTodaysWeatherWithErrorMessage(errorMessage)
    }
}