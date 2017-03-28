//
//  MeasurementTests.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import XCTest

@testable import AirQlt

class MeasurementTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAirMeasurementFetchSuccess() {

        let anExpectation = expectation(description: "alamofire model check")
        let airMeasurement = AirMeasurement()
        airMeasurement.fetchMeasurements(city: "1", completionHandlerSuccess: { dictionary in
            anExpectation.fulfill()
        }, completionHandlerFailure: nil)
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
