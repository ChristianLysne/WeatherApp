//
//  TodaysWeatherConfigurator.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct TodaysWeatherConfigurator {
    
    static let sharedInstance = TodaysWeatherConfigurator()
    
    private init() {
        // Enforce Singleton Pattern
    }
    
    func configure(viewController: TodaysWeatherViewController, client: HTTPClient) {
        
        var presenter = TodaysWeatherPresenter()
        presenter.output = viewController
        
        var interactor = TodaysWeatherInteractor()
        interactor.client = client
        interactor.output = presenter
        
        viewController.output = interactor
    }
}