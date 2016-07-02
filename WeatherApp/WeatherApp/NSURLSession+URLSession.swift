//
//  NSURLSession+URLSession.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

extension NSURLSession: URLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: URLSessionResult) -> URLSessionDataTask {
        return (dataTaskWithURL(url, completionHandler: completionHandler) as NSURLSessionDataTask) as URLSessionDataTask
    }
}