//
//  TodaysWeatherViewModel.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

typealias InfoTextAndIcon = (infoText: NSAttributedString, image: UIImage)

struct TodaysWeatherViewModel {
    
    let locationAttributedString: NSAttributedString
    let temperatureAttributedString: NSAttributedString
    let temperatureMaxInfoTextAndIcon: InfoTextAndIcon
    let temperatureMinInfoTextAndIcon: InfoTextAndIcon
    let windSpeedInfoTextAndIcon: InfoTextAndIcon
    let rainInfoTextAndIcon: InfoTextAndIcon
    let weatherIconImage: UIImage?
    let windIconAngle: Float
    
    private let locationFontSize: CGFloat = 30
    private let temperatureFontSize: CGFloat = 80
    private let infoFontSize: CGFloat = 18
    
    private let tempMaxImage = UIImage(named: "ArrowUp")!
    private let tempMinImage = UIImage(named: "ArrowDown")!
    private let windImage = UIImage(named: "ArrowWind")!
    private let rainImage = UIImage(named: "RainDrop")!
    
    init(todaysWeather: TodaysWeather) {
        
        locationAttributedString = getAttributedStringForText(todaysWeather.locationName,
                                                              fontSize: locationFontSize,
                                                              alignment: .Center,
                                                              postfix: nil,
                                                              shrinkPostfix: false)
        temperatureAttributedString = getAttributedStringForText(String(todaysWeather.temp),
                                                                 fontSize: temperatureFontSize,
                                                                 alignment: .Center,
                                                                 postfix: "°",
                                                                 shrinkPostfix: false)
        
        temperatureMaxInfoTextAndIcon = (getAttributedStringForText(String(todaysWeather.tempMax),
                                                                   fontSize: infoFontSize,
                                                                   alignment: .Left,
                                                                   postfix: "°",
                                                                   shrinkPostfix: false), tempMaxImage)
        temperatureMinInfoTextAndIcon = (getAttributedStringForText(String(todaysWeather.tempMin),
                                                                   fontSize: infoFontSize,
                                                                   alignment: .Left,
                                                                   postfix: "°",
                                                                   shrinkPostfix: false), tempMinImage)
        windSpeedInfoTextAndIcon = (getAttributedStringForText(String(todaysWeather.windSpeed),
                                                              fontSize: infoFontSize,
                                                              alignment: .Left,
                                                              postfix: " mps",
                                                              shrinkPostfix: true), windImage)
        
        let rain = todaysWeather.rainInMM ?? 0
        rainInfoTextAndIcon = (getAttributedStringForText(String(rain),
                                                         fontSize: infoFontSize,
                                                         alignment: .Left,
                                                         postfix: " mm",
                                                         shrinkPostfix: true), rainImage)
        
        let iconName = todaysWeather.icon.stringByReplacingOccurrencesOfString("n", withString: "d")
        weatherIconImage = UIImage(named: iconName)
        windIconAngle = todaysWeather.windDegrees
    }
}

private func getAttributedStringForText(text: String, fontSize: CGFloat, alignment: NSTextAlignment, postfix: String?, shrinkPostfix: Bool) -> NSAttributedString {
    
    let stringToDisplay = [text, postfix].flatMap{$0}.joinWithSeparator("")
    let attributedString = NSMutableAttributedString(string: stringToDisplay)
    let wordRange = NSMakeRange(0, (stringToDisplay as NSString).length)
    
    let style = NSMutableParagraphStyle()
    style.alignment = alignment
    
    let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                      NSFontAttributeName : UIFont.systemFontOfSize(fontSize),
                      NSParagraphStyleAttributeName: style]
    attributedString.addAttributes(attributes, range: wordRange)
    
    if let postfix = postfix where shrinkPostfix {
        let range = (stringToDisplay as NSString).rangeOfString("\(postfix)")
        attributedString.addAttribute(NSFontAttributeName,
                                      value: UIFont.systemFontOfSize(fontSize/2),
                                      range: range)
    }
    
    return attributedString
}