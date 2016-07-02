
//
//  UITestHelper
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

class TestHelper {
    func readJSONFromFile(fileName: String) -> String {
        
        // Fail fast, since this is only static files in UITest folder
        let path = NSBundle(forClass: self.dynamicType).pathForResource(fileName, ofType: "json")
        let jsonData = try! NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        if let string = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String {
            return string
        }
        return ""
    }
}
