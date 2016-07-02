//
//  NSHTTPURLResponse+StatusCode.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

extension NSHTTPURLResponse {
    convenience init?(statusCode: Int) {
        self.init(URL: NSURL(),
                  statusCode: statusCode,
                  HTTPVersion: nil,
                  headerFields: nil)
    }
}