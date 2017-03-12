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
    
    func testLabelsSetProperly() {
        XCTAssert(vc.pollutionPartName.text == "CO")
        XCTAssert(vc.actualDensityNumber.text == "5.5")
        XCTAssert(vc.whenMeasuredTime.text == "")
        XCTAssert(vc.pollutionPercentage.text == "5.5")
    }
    
    func testCollectionViewSetProperly() {
        XCTAssertNotNil(vc)
        
        let cell = vc.collectionView(vc.measurementsCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! MeasureCollectionViewCell
        XCTAssertNotNil(cell)
        XCTAssert(cell.airPollutionPartName.text == "CO")
        XCTAssert(cell.airPollutionPartPercentageNumber.text == "5.5")
        XCTAssert(cell.airPollutionPartUnitNumber.text == "5.5")
        XCTAssert(cell.unitLabel.text == "μg/m3")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
