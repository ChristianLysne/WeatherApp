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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInteractorCallsPresentTodaysWeatherWhenReceivingAValidResponse() {
        let output = MockTodaysWeatherInteractorOutput()
        
        let testHelper = TestHelper()
        let expectedData = testHelper.readJSONFromFile("BayswaterExample")
        
        urlSession.data = expectedData.nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor()
        interactor.output = output
        interactor.client = client
        interactor.locationManager = MockLocation()
        
        interactor.updateTodaysWeather()
        
        XCTAssertTrue(output.presentTodaysWeatherCalled)
        XCTAssertFalse(output.failedUpdatingTodaysWeatherCalled)
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
    
    //MARK: Mocks
    class MockTodaysWeatherViewControllerOutput: TodaysWeatherViewControllerOutput {
        private (set) var updateTodaysWeatherCalled = false
        
        func updateTodaysWeather() {
            updateTodaysWeatherCalled = true
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
        
        func location() -> CLLocation? {
            let latitude: CLLocationDegrees = 51.508369
            let longitude: CLLocationDegrees = -0.176125
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        func startTrackingLocation() {
            
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