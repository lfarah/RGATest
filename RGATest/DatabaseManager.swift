//
//  DatabaseManager.swift
//  RGATest
//
//  Created by Lucas Farah on 2/17/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable force_try
// swiftlint:disable trailing_whitespace

import Foundation
import RealmSwift

class DatabaseManager {
    
    var realm: Realm! {
        
            if NSClassFromString("XCTest") != nil || ProcessInfo.processInfo.arguments.contains("testMode") {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Tests"
            }

            let realm = try! Realm()
            return realm
   }
    
    func save(contact: Contact) {
        
        do {
            
            try realm.write {
                realm.add(contact, update: true)
            }
        } catch let error {
            
            print(error)
        }
    }
    
    func remove(contact: Contact) {
        
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func getContacts() -> Results<Contact> {
        
        let rounds = realm.objects(Contact.self)
        
        print(rounds.count)
        return rounds.sorted(byKeyPath: "name")
    }
    
    func searchContacts(text: String) -> Results<Contact> {
        
        let contacts = realm.objects(Contact.self).filter("name CONTAINS[c] '\(text)'")
        return contacts
    }
    
    func save(image: UIImage?) -> String? {
        
        if let image = image {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            let data = UIImageJPEGRepresentation(image, 1)!
            let uniqueName = Date().timeIntervalSince1970.toString
            let filename = documentsDirectory.appendingPathComponent("\(uniqueName).png")
            try? data.write(to: filename)
            return filename.absoluteString
        } else {
            return nil
        }
    }
}
