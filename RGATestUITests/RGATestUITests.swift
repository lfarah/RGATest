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
        
        app.launchArguments = ["testMode"]

        continueAfterFailure = false
        app.launch()
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
    
    func testSearch() {
        
        let searchField = app.searchFields["Buscar Contato"]
        searchField.tap()
        searchField.typeText("Name person5")
        app.buttons["Search"].tap()
        
        // Name Person 5 should appear
        let person5 = app.tables.staticTexts["Name Person5"]
        XCTAssertTrue(person5.exists)
        
        // TableView should only have one contact
        let cellCount = app.tables.count
        XCTAssertEqual(cellCount, 1)
    }
    
}
