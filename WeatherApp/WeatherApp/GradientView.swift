//
//  GradientView.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGradientBackground()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
    }
    
    private func addGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [
            Constants.Colors.Blue.CGColor,
            Constants.Colors.Green.CGColor
        ]
        layer.insertSublayer(gradientLayer, atIndex: 0)
    }
}