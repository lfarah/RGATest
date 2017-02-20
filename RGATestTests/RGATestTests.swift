//
//  RGATestTests.swift
//  RGATestTests
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import XCTest
@testable import RGATest

class RGATestTests: XCTestCase {
    
    var viewModel = ContactViewModel()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetContacts() {
        viewModel.getContacts { (contacts) in
            XCTAssertTrue(contacts.count > 0)
        }
    }
    
    func testSearch() {
        
        viewModel.getContacts {_ in
            let contacts = self.viewModel.searchContacts(text: "Name Person5")
            XCTAssertEqual(contacts.count, 1)
        }
    }
}
