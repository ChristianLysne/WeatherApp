//
//  TodaysWeatherView.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class TodaysWeatherView: XibLoadingView {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureMaxInfoLabelWithIconView: InfoLabelAndIconView!
    @IBOutlet weak var temperatureMinInfoLabelAndIconView: InfoLabelAndIconView!
    @IBOutlet weak var windInfoLabelAndIconView: InfoLabelAndIconView!
    @IBOutlet weak var rainInfoLabelAndIconView: InfoLabelAndIconView!
    
    func configureViewWithViewModel(viewModel: TodaysWeatherViewModel) {
        
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
        if let image = viewModel.weatherIconImage {
            self.weatherImageView.image = image
        }
        
        if let angle = viewModel.windIconAngle {
            self.windInfoLabelAndIconView.iconImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(angle).degreesToRadians)
        }
    }
}