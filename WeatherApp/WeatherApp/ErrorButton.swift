//
//  ErrorButton.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class ErrorButton: UIButton {
    
    var error: UpdateWeatherError?
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        layer.borderColor = Constants.Colors.TodaysWeatherInfo.CGColor
        layer.borderWidth = 1
    }
}