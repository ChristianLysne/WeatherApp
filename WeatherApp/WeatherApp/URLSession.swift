//
//  URLSession.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

typealias URLSessionResult = (NSData?, NSURLResponse?, NSError?) -> Void

protocol URLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: URLSessionResult) -> URLSessionDataTask
}