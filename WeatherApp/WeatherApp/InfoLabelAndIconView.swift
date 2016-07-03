//
//  InfoLabelWithIconView.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class InfoLabelAndIconView: XibLoadingView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    func configureWithInfoTextAndIcon(infoTextAndIcon: InfoTextAndIcon, tintColor: UIColor) {
        infoLabel.attributedText = infoTextAndIcon.infoText
        
        iconImageView.image = infoTextAndIcon.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        iconImageView.tintColor = tintColor
    }
}