//
//  LocationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import UIKit


class LocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    func configureWithName(name: String?) {
        locationNameLabel.text = name
    }
}
