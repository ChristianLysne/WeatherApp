//
//  UIImageView+SetImageFromURL.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromURL(url: NSURL) {
       (NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.image = UIImage(data: data!)
            }
        } as NSURLSessionDataTask).resume()
    }
}