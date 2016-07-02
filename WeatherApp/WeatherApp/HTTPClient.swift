//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

enum HTTPError: ErrorType {
    case NetworkError
}

typealias HTTPResult = (NSData?, ErrorType?) -> Void

class HTTPClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = Config.urlSession) {
        self.urlSession = urlSession
    }
    
    func get(url: NSURL, completion: HTTPResult) {
        let task = urlSession.dataTaskWithURL(url) { (data, response, error) in
            if error != nil  {
                completion(nil, HTTPError.NetworkError)
            } else if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                completion(data, nil)
            } else {
                completion(nil, HTTPError.NetworkError)
            }
        }
        task.resume()
    }
}