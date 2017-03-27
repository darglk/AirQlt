//
//  AirQltTests.swift
//  AirQltTests
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import XCTest
import OHHTTPStubs
import Alamofire

@testable import AirQlt

class AirQltTests: XCTestCase {
    
    var vc:MesauermentViewController!
    
    let responseText = "\"{\"status\":\"ok\",\"data\":{\"aqi\":29,\"idx\":1,\"attributions\":[{\"url\":\"http://www.airqualityontario.com/\",\"name\":\"Air Quality Ontario - the Ontario Ministry of the Environment and Climate Change\"}],\"city\":{\"geo\":[44.150528,-77.3955],\"name\":\"Belleville, Ontario\",\"url\":\"http://aqicn.org/city/canada/ontario/belleville/\"},\"dominentpol\":\"o3\",\"iaqi\":{\"h\":{\"v\":100},\"no2\":{\"v\":1.9},\"o3\":{\"v\":28.9},\"p\":{\"v\":1028},\"pm25\":{\"v\":13},\"t\":{\"v\":-0.44}},\"time\":{\"s\":\"2017-03-26 07:00:00\",\"tz\":\"-05:00\",\"v\":1490511600}}}\""
    
    override func setUp() {
        super.setUp()
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "MeasurementViewController") as! MesauermentViewController
        vc.stubsOn()
        _ = vc.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlamofire() {
        let anExpectation = expectation(description: "Check Alamofire")
        
        Alamofire.request("https://api.waqi.info/feed/@1/?token=\(API_KEY)").responseJSON { response in
            print(response)
            anExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
        
    }
    
    func testViewsSetProperly() {
        XCTAssertNotNil(vc)
        let measurement = AirMeasurement()
        measurement.airQualityIndexes.append(AirQualityIndex(airQualityIndexName: "CO", airQualityIndexValue: 5.5, airQualityLongValue: "Tlenek węgla"))
        vc.measurement = measurement
        let cell = vc.collectionView(vc.measurementsCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! MeasureCollectionViewCell
        XCTAssertNotNil(cell)
        XCTAssert(cell.airPollutionPartName.text == vc.measurement.airQualityIndexes[0].airQualityIndexName)
        XCTAssert(cell.airPollutionPartUnitNumber.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
        XCTAssert(cell.unitLabel.text == "μg/m3")
        vc.setLabelsAtIndex(index: 0)
        XCTAssert(vc.pollutionPartName.text == vc.measurement.airQualityIndexes[0].airQualityIndexName)
        XCTAssert(vc.actualDensityNumber.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
        XCTAssert(vc.whenMeasuredTime.text == vc.measurement.whenMeasured)
    }
    
    func testFetchingFromApi() {
        
        let anExpectation = expectation(description: "Check Alamofire")
        
        waitForExpectations(timeout: 20.0, handler: nil)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
