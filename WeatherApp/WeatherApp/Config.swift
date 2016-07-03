//
//  Config.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct Config {
    static let urlSession: NSURLSession = UITesting() ? SeededURLSession() : NSURLSession.sharedSession()
}

func UITesting() -> Bool {
    return NSProcessInfo.processInfo().arguments.contains("UITesting")
}