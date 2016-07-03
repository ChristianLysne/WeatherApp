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
    
    let latitude: CLLocationDegrees = 51.508369
    let longitude: CLLocationDegrees = -0.176125
    
    override func setUp() {
        super.setUp()
        
        client = HTTPClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewControllerRequestsTodaysWeather() {
        
        let output = MockTodaysWeatherViewControllerOutput()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        self.viewController = storyboard.instantiateInitialViewController() as! TodaysWeatherViewController
        self.viewController.client = client
        self.viewController.output = output
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
        
        self.viewController.updatedLocation(CLLocation(latitude: latitude, longitude: longitude))
        
        XCTAssertTrue(output.updateTodaysWeatherCalled)
    }
    
    func testInteractorCallsPresentTodaysWeatherWhenReceivingAValidResponse() {
        let output = MockTodaysWeatherInteractorOutput()
        
        let testHelper = TestHelper()
        let expectedData = testHelper.readJSONFromFile("BayswaterExample")
        
        urlSession.data = expectedData.nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor(output: output, client: client)
        
        interactor.updateTodaysWeatherForLatitude(latitude, longitude: longitude)
        
        XCTAssertTrue(output.presentTodaysWeatherCalled)
        XCTAssertFalse(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfDataIsEmpty() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = nil
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor(output: output, client: client)
        
        interactor.updateTodaysWeatherForLatitude(latitude, longitude: longitude)
        
        XCTAssertFalse(output.presentTodaysWeatherCalled)
        XCTAssertTrue(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfConversionToJSONFails() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = "Response".nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor(output: output, client: client)
        
        interactor.updateTodaysWeatherForLatitude(latitude, longitude: longitude)
        
        XCTAssertFalse(output.presentTodaysWeatherCalled)
        XCTAssertTrue(output.failedUpdatingTodaysWeatherCalled)
    }
    
    func testInteractorCallsFailedUpdatingTodaysWeatherIfParsingOfObjectFailed() {
        let output = MockTodaysWeatherInteractorOutput()
        
        urlSession.data = "{\"this\":\"should fail parsing\"}".nsutf8StringEncoding
        urlSession.response = NSHTTPURLResponse(statusCode: 200)
        let interactor = TodaysWeatherInteractor(output: output, client: client)
        
        interactor.updateTodaysWeatherForLatitude(latitude, longitude: longitude)
        
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
        presenter.failedUpdatingTodaysWeather()
        
        XCTAssertTrue(output.failedUpdatingTodaysWeatherWithErrorMessageCalled)
    }
    
    //MARK: Mocks
    class MockTodaysWeatherViewControllerOutput: TodaysWeatherViewControllerOutput {
        private (set) var updateTodaysWeatherCalled = false
        
        func updateTodaysWeatherForLatitude(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            updateTodaysWeatherCalled = true
        }
    }
    
    class MockTodaysWeatherInteractorOutput: TodaysWeatherInteractorOutput {
        private (set) var presentTodaysWeatherCalled = false
        private (set) var failedUpdatingTodaysWeatherCalled = false

        func presentTodaysWeather(todaysWeather: TodaysWeather) {
            presentTodaysWeatherCalled = true
        }
        
        func failedUpdatingTodaysWeather() {
            failedUpdatingTodaysWeatherCalled = true
        }
    }
    
    class MockTodaysWeatherPresenterOutput: TodaysWeatherPresenterOutput {
        private (set) var displayTodaysWeatherCalled = false
        private (set) var failedUpdatingTodaysWeatherWithErrorMessageCalled = false

        func displayTodaysWeather(todaysWeatherViewModel: TodaysWeatherViewModel) {
            displayTodaysWeatherCalled = true
        }
        
        func failedUpdatingTodaysWeatherWithErrorMessage(errorMessage: NSAttributedString) {
            failedUpdatingTodaysWeatherWithErrorMessageCalled = true
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