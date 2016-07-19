//
//  LocationsViewControllerTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 19/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationsViewControllerTests: XCTestCase {
    
    var viewController: LocationsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        self.viewController = storyboard.instantiateViewControllerWithIdentifier("LocationsViewController") as! LocationsViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresetLocationsAreDisplayed() {
        
        let presetLocations = StoredLocationsManager.getPresetLocations()
        
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), presetLocations.count)
    }
    
    func testLocationChangedCallsDelegate() {
        
        let mockLocationChangedDelegate = MockLocationChangedDelegate()
        
        viewController.locationChangedDelegate = mockLocationChangedDelegate
        
        XCTAssertFalse(mockLocationChangedDelegate.locationChangedCalled)
        
        viewController.collectionView(viewController.collectionView, didSelectItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertTrue(mockLocationChangedDelegate.locationChangedCalled)
    }
}

class MockLocationChangedDelegate: LocationChangedDelegate {
    private (set) var locationChangedCalled = false
    
    func locationChanged(location: StoredLocation) {
        locationChangedCalled = true
    }
}