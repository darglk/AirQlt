//
//  MeasurementTests.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import AirQlt

class MeasurementTests: XCTestCase {
    
    let responseText = "\"{\"status\":\"ok\",\"data\":{\"aqi\":29,\"idx\":1,\"attributions\":[{\"url\":\"http://www.airqualityontario.com/\",\"name\":\"Air Quality Ontario - the Ontario Ministry of the Environment and Climate Change\"}],\"city\":{\"geo\":[44.150528,-77.3955],\"name\":\"Belleville, Ontario\",\"url\":\"http://aqicn.org/city/canada/ontario/belleville/\"},\"dominentpol\":\"o3\",\"iaqi\":{\"h\":{\"v\":100},\"no2\":{\"v\":1.9},\"o3\":{\"v\":28.9},\"p\":{\"v\":1028},\"pm25\":{\"v\":13},\"t\":{\"v\":-0.44}},\"time\":{\"s\":\"2017-03-26 07:00:00\",\"tz\":\"-05:00\",\"v\":1490511600}}}\""
    
    override func setUp() {
        super.setUp()
        stub(condition: isHost("https://api.waqi.info/feed/@1/?token=\(API_KEY)"), response: { response in
            let stubData = self.responseText.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode: 200, headers: nil)
            
        })
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAirMeasurementFields() {
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
