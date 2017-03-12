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
    
    func testApiCommunicator() {
        let apiCommunicatorImpl = APICommunicator(URLAddress: "www.google.pl")
        XCTAssertTrue(apiCommunicatorImpl.get() == nil)
    }
    
    func testApiCommunicatorStub() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let apiCommunicator = PAPICommunicatorStub(URLAddress: "www.google.com")
        let mesasurement = AirMeasurement(apiCommunicator: apiCommunicator)
        mesasurement.fetchMeasurement()
        XCTAssertTrue(apiCommunicator.getWasCalled)
    }
    
    func testAirMeasurementFields() {
        let airQualityIndex = AirQualityIndex(airQualityIndexName: "CO", airQualityIndexValue: 5.5)
        XCTAssert(airQualityIndex.airQualityIndexName == "CO")
        XCTAssert(airQualityIndex.airQualityIndexValue == 5.5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
