
//
//  AirQltUITests.swift
//  AirQltUITests
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import XCTest

class AirQltUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .faceUp
        
        let app = XCUIApplication()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"p").children(matching: .staticText)["1020.0"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"t").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"h").element.tap()
        
        let backgroundLeftSidebarElementsQuery = app.otherElements.containing(.image, identifier:"background_left_sidebar")
        backgroundLeftSidebarElementsQuery.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"no2").children(matching: .staticText)["18.2"].tap()
        app.navigationBars["Kraków-ul. Dietla, Małopolska"].buttons["Menu"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Pomiary"].tap()
        tablesQuery.staticTexts["Ustawienia"].tap()
        tablesQuery.staticTexts["Informacje"].tap()
        backgroundLeftSidebarElementsQuery.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
    }
    
}
