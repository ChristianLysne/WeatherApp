//
//  TodaysWeatherTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class TodaysWeatherTests: XCTestCase {
    
    var client: HTTPClient!
    let urlSession = MockURLSession()
    var viewController: TodaysWeatherViewController!
    
    override func setUp() {
        super.setUp()
        
        client = HTTPClient(urlSession: urlSession)
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        self.viewController = storyboard.instantiateViewControllerWithIdentifier("TodaysWeatherViewController") as! TodaysWeatherViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInteractorCallsPresentTodaysWeatherWhenReceivingAValidResponse() {
        let output = MockTodaysWeatherInteractorOutput()
        
        let testHelper = TestHelper()
        let location = MockLocation()
        let expectedData = testHelper.readJSONFromFile("BayswaterExample")
        
        urlSession.data = expectedData.nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor()
        interactor.output = output
        interactor.client = client
        interactor.locationManager = location
        
        interactor.updateTodaysWeather()
        
        XCTAssertTrue(output.presentTodaysWeatherCalled)
        XCTAssertFalse(output.failedUpdatingTodaysWeatherCalled)
        XCTAssertTrue(location.startTrackingLocationCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfDataIsEmpty() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = nil
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor()
        interactor.output = output
        interactor.client = client
        
        interactor.updateTodaysWeather()
        
        XCTAssertFalse(output.presentTodaysWeatherCalled)
        XCTAssertTrue(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfConversionToJSONFails() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = "Response".nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor()
        interactor.output = output
        interactor.client = client
        
        interactor.updateTodaysWeather()
        
        XCTAssertFalse(output.presentTodaysWeatherCalled)
        XCTAssertTrue(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfParsingOfObjectFailed() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = "{\"this\":\"should fail parsing\"}".nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor()
        interactor.output = output
        interactor.client = client
        
        interactor.updateTodaysWeather()
        
        XCTAssertFalse(output.presentTodaysWeatherCalled)
        XCTAssertTrue(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testPresenterCallsDisplayTodaysWeatherWhenPresentTodaysWeatherIsCalled() {
        let output = MockTodaysWeatherPresenterOutput()
        let presenter = TodaysWeatherPresenter(output: output)
        
        let todaysWeather = TodaysWeather(id: 0,
                                          locationName: "",
                                          icon: "",
                                          temp: 0,
                                          tempMin: 0,
                                          tempMax: 0,
                                          windSpeed: 0,
                                          windDegrees: 0,
                                          rainInMM: 0,
                                          time: NSDate())
        
        presenter.presentTodaysWeather(todaysWeather)
        
        XCTAssertTrue(output.displayTodaysWeatherCalled)
    }
    
    func testPresenterOutputErrorMessageIfRequestFails() {
        let output = MockTodaysWeatherPresenterOutput()
        
        let presenter = TodaysWeatherPresenter(output: output)
        presenter.failedUpdatingTodaysWeatherWithError(.FailedToLoadData)
        
        XCTAssertTrue(output.failedUpdatingTodaysWeatherWithErrorMessageCalled)
    }
    
    func testPresenterOutputErrorMessageIfLocationNotFound() {
        let output = MockTodaysWeatherPresenterOutput()
        
        let presenter = TodaysWeatherPresenter(output: output)
        presenter.failedUpdatingTodaysWeatherWithError(.LocationNotFound)
        
        XCTAssertTrue(output.failedUpdatingTodaysWeatherWithErrorMessageCalled)
    }
    
    func testPresenterOutputErrorMessageIfLocationNotPermitted() {
        let output = MockTodaysWeatherPresenterOutput()
        
        let presenter = TodaysWeatherPresenter(output: output)
        presenter.failedUpdatingTodaysWeatherWithError(.NoPermission)
        
        XCTAssertTrue(output.failedUpdatingTodaysWeatherWithErrorMessageCalled)
    }
    
    func testViewControllerOutputCallsUpdateWeatherForLocation() {
        let output = MockTodaysWeatherViewControllerOutput()
        
        viewController.output = output
        
        XCTAssertFalse(output.updateWeatherForLocationCalled)
        
        viewController.locationChanged(StoredLocation(name: "name"))
        
        XCTAssertTrue(output.updateWeatherForLocationCalled)
    }
    
    func testInteractorStopsTrackingLocationForManualLocation() {
        let location = MockLocation()
        
        let interactor = TodaysWeatherInteractor()
        interactor.locationManager = location
        
        interactor.updateWeatherForLocation(StoredLocation(name: "name"))
        
        XCTAssertTrue(location.stopTrackingLocationCalled)
    }
    
    //MARK: Mocks
    class MockTodaysWeatherViewControllerOutput: TodaysWeatherViewControllerOutput {
        private (set) var updateTodaysWeatherCalled = false
        private (set) var updateWeatherForLocationCalled = false
        
        func updateTodaysWeather() {
            updateTodaysWeatherCalled = true
        }
        
        func updateWeatherForLocation(location: StoredLocation) {
            updateWeatherForLocationCalled = true
        }

    }
    
    class MockTodaysWeatherInteractorOutput: TodaysWeatherInteractorOutput {
        private (set) var presentTodaysWeatherCalled = false
        private (set) var failedUpdatingTodaysWeatherCalled = false

        func presentTodaysWeather(todaysWeather: TodaysWeather) {
            presentTodaysWeatherCalled = true
        }
        
        func failedUpdatingTodaysWeatherWithError(error: UpdateWeatherError) {
            failedUpdatingTodaysWeatherCalled = true
        }
    }
    
    class MockTodaysWeatherPresenterOutput: TodaysWeatherPresenterOutput {
        private (set) var displayTodaysWeatherCalled = false
        private (set) var failedUpdatingTodaysWeatherWithErrorMessageCalled = false

        func displayTodaysWeather(todaysWeatherViewModel: TodaysWeatherViewModel) {
            displayTodaysWeatherCalled = true
        }
        
        func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString, buttonText: String?, error: UpdateWeatherError) {
            failedUpdatingTodaysWeatherWithErrorMessageCalled = true
        }
    }
    
    class MockLocation: Location {
        weak var locationDelegate: LocationDelegate?
        private (set) var startTrackingLocationCalled = false
        private (set) var stopTrackingLocationCalled = false
        
        func location() -> CLLocation? {
            let latitude: CLLocationDegrees = 51.508369
            let longitude: CLLocationDegrees = -0.176125
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        func startTrackingLocation() {
            startTrackingLocationCalled = true
        }
        
        func stopTrackingLocation() {
            stopTrackingLocationCalled = true
        }
    }
    
    class MockURLSession: URLSession {
        private (set) var url: NSURL?
        var dataTask = MockURLSessionDataTask()
        var data: NSData?
        var error: NSError?
        var response: NSHTTPURLResponse?
        
        func dataTaskWithURL(url: NSURL, completionHandler: URLSessionResult) -> URLSessionDataTask {
            self.url = url
            completionHandler(data, response, error)
            return dataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        private (set) var resumeCalled = false
        
        func resume() {
            resumeCalled = true
        }
    }
}