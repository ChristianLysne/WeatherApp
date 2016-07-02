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
        let attributes = [
            NSForegroundColorAttributeName: UIColor.greenColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(22.0)]
        let errorMessage = NSAttributedString(string: "Failed to update todays weather 😞", attributes: attributes)
        output.failedUpdatingTodaysWeatherWithErrorMessage(errorMessage)
    }
}