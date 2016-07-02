//
//  String+NSUTF8StringEncoding.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

extension String {
    var nsutf8StringEncoding: NSData? {
        return self.dataUsingEncoding(NSUTF8StringEncoding)
    }
}