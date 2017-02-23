//
//  DatabaseManager.swift
//  ShakeIt
//
//  Created by Lucas Farah on 2/17/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable force_try
// swiftlint:disable trailing_whitespace

import Foundation
import Realm
import RealmSwift

class DatabaseManager {
    
    func save(contact: Contact) {
        
        let realm = try! Realm()
        do {
            
            try realm.write {
                realm.add(contact)
            }
        } catch let error {
            
            print(error)
        }
    }
    
    func remove(contact: Contact) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func getContacts() -> Results<Contact> {
        
        let realm = try! Realm()
        let rounds = realm.objects(Contact.self)
        
        print(rounds.count)
        return rounds.sorted(byKeyPath: "name")
    }
    
    func searchContacts(text: String) -> Results<Contact> {
        
        let realm = try! Realm()
        let contacts = realm.objects(Contact.self).filter("name contains '\(text)'")
        return contacts
    }
}
