//
//  AirQltTests.swift
//  AirQltTests
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import XCTest
@testable import AirQlt

class AirQltTests: XCTestCase {
    
    var vc:MesauermentViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "MeasurementViewController") as! MesauermentViewController
        _ = vc.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewsSetProperly() {
        XCTAssertNotNil(vc)
        let measurement = AirMeasurement()
        measurement.airQualityIndexes.append(AirQualityIndex(airQualityIndexName: "CO", airQualityIndexValue: 5.5, airQualityLongValue: "Tlenek węgla"))
        vc.measurement = measurement
        let cell = vc.collectionView(vc.measurementsCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! MeasureCollectionViewCell
        XCTAssertNotNil(cell)
        XCTAssert(cell.airPollutionPartName.text == vc.measurement.airQualityIndexes[0].airQualityIndexName)
        XCTAssert(cell.airPollutionPartPercentageNumber.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
        XCTAssert(cell.airPollutionPartUnitNumber.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
        XCTAssert(cell.unitLabel.text == "μg/m3")
        vc.setLabelsAtIndex(index: 0)
        XCTAssert(vc.pollutionPartName.text == vc.measurement.airQualityIndexes[0].airQualityIndexName)
        XCTAssert(vc.actualDensityNumber.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
        XCTAssert(vc.whenMeasuredTime.text == vc.measurement.whenMeasured)
        XCTAssert(vc.pollutionPercentage.text == String(vc.measurement.airQualityIndexes[0].airQualityIndexValue))
    }
    
    func testFetchingFromApi() {
        vc.fetchRecordsFromApi(city: "krakow", completionHandler: { string in
            XCTAssertNotNil(string, "Expected non nil string")
        })
        //waitForExpectations(timeout: 5.0, handler: nil)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
