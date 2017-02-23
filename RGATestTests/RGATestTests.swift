//
//  RGATestTests.swift
//  RGATestTests
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import XCTest
@testable import RGATest
@testable import RealmSwift

class RGATestTests: XCTestCase {
    
    var viewModel = ContactViewModel()
    var initialContacts: Results<Contact>?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let expect = expectation(description: "initialContacts")
        viewModel.getContacts { (contacts) in
            print("MEH")
            self.initialContacts = contacts
            expect.fulfill()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetContacts() {
        
        let exp = expectation(description: "testGetContacts")
        viewModel.getContacts { (contacts) in
            
            exp.fulfill()
            if let contacts = contacts {
                print(contacts.count)
                XCTAssertTrue(contacts.count > 0)
            } else {
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSearch() {
        _ = waitForExpectations(timeout: 10) { (_) in
            
            let contacts = self.viewModel.searchContacts(text: "Name Person5")
            XCTAssertEqual(contacts.count, 1)
        }
    }
    
    func testDeleteContact() {
        
        _ = waitForExpectations(timeout: 10) { (_) in
            
            let contact = DatabaseManager().getContacts().first
            self.viewModel.remove(contact: contact!)
            XCTAssertTrue(contact!.isInvalidated)
        }
    }
    
    func testAddContact() {
        
        _ = waitForExpectations(timeout: 10) { (_) in
            
            let contact = Contact()
            contact.name = "Lorem ipsum dolor"
            contact.email = "name@me.com"
            contact.bio = "Lorem ipsum dolor sit amet"
            contact.birthdate = Date()
            contact.photoURL = ""
            contact.id = ContactViewModel().generateUniqueId()
            self.viewModel.add(contact: contact)
            
            let contacts = self.viewModel.searchContacts(text: "Lorem ipsum dolor")
            XCTAssertEqual(contacts.first!.id, contact.id)
        }
    }
}
