//
//  HTTPClientTests.swift
//  WeatherApp
//
//  Created by Christian Lysne on 02/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HTTPClientTests: XCTestCase {
    
    var client: HTTPClient!
    let urlSession = MockURLSession()
    
    override func setUp() {
        super.setUp()
        
        client = HTTPClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Tests
    func testGetRequestsTheURL() {
        let url = NSURL(string: "http://test.com")!
        client.get(url) { (_, _) in }
        
        XCTAssertEqual(urlSession.url, url)
    }
    
    func testGetStartsTheRequest() {
        urlSession.dataTask = MockURLSessionDataTask()
        client.get(NSURL()) { (_, _) in }
        
        XCTAssertTrue(urlSession.dataTask.resumeCalled)
    }
    
    func testGetWithResponseDataReturnsData() {
        let expectedData = "Response".nsutf8StringEncoding
        urlSession.data = expectedData
        urlSession.response = NSHTTPURLResponse(statusCode: 200)

        var actualData: NSData?
        client.get(NSURL()) { (data, _) in
            actualData = data
        }
        
        XCTAssertEqual(actualData, expectedData)
    }
    
    func testGetWithNetworkErrorReturnsNetworkError() {
        urlSession.error = NSError(domain: "error", code: 408, userInfo: nil)
        
        var errorReceived: ErrorType?
        client.get(NSURL()) { (_, error) in
            errorReceived = error
        }
        
        XCTAssertNotNil(errorReceived)
    }
    
    func testGetWithStatusCodeUnder200ReturnsError() {
        urlSession.response = NSHTTPURLResponse(statusCode: 199)
        
        var errorReceived: ErrorType?
        client.get(NSURL()) { (_, error) in
            errorReceived = error
        }
        
        XCTAssertNotNil(errorReceived)
    }
    
    func testGetWithStatusCodeOver299ReturnsError() {
        urlSession.response = NSHTTPURLResponse(statusCode: 300)
        
        var errorReceived: ErrorType?
        client.get(NSURL()) { (_, error) in
            errorReceived = error
        }
        
        XCTAssertNotNil(errorReceived)
    }
    
    //MARK: Mocks
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