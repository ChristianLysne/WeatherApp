//
//  SeededDataTask.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

class SeededDataTask: NSURLSessionDataTask {
    private let url: NSURL
    private let completion: DataCompletion
    
    init(url: NSURL, completion: DataCompletion) {
        self.url = url
        self.completion = completion
    }
    
    override func resume() {
        if let json = NSProcessInfo.processInfo().environment[url.absoluteString] {
            let response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
            let data = json.nsutf8StringEncoding
            completion(data, response, nil)
        }
    }
}