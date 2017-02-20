//
//  RGATestUITests.swift
//  RGATestUITests
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace

import XCTest

class RGATestUITests: XCTestCase {
    
    var app = XCUIApplication()
    
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
    
    func testEditAndRemove() {
        
        let editiconButton = app.navigationBars["Contatos"].buttons["EditIcon"]
        editiconButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery.buttons["Delete Name Person2"].tap()
        tablesQuery.buttons["Delete"].tap()
        editiconButton.tap()
    }
    
    func testSwipeToDelete() {
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Name Person4"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
    }
    
}
