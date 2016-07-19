//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

protocol LocationChangedDelegate: class {
    func locationChanged(location: StoredLocation)
}

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var locationChangedDelegate: LocationChangedDelegate?
    
    let cellPadding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension LocationsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StoredLocationsManager.getPresetLocations().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let storedLocation = StoredLocationsManager.getPresetLocations()[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LocationCollectionViewCell", forIndexPath: indexPath) as! LocationCollectionViewCell
        
        cell.configureWithName(storedLocation.name)
        
        return cell
    }
}

extension LocationsViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storedLocation = StoredLocationsManager.getPresetLocations()[indexPath.row]
        locationChangedDelegate?.locationChanged(storedLocation)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - cellPadding, height: self.view.frame.height/3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}
