//
//  SeededURLSession.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

typealias DataCompletion = (NSData?, NSURLResponse?, NSError?) -> Void

class SeededURLSession: NSURLSession {
    override func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        return SeededDataTask(url: url, completion: completionHandler)
    }
}