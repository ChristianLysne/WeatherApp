//
//  CGFloat+DegreesToRadians.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    var degreesToRadians: CGFloat {
        return self * CGFloat(M_PI) / 180
    }
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat(M_PI)
    }
}