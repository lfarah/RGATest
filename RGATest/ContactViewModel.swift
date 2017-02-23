//
//  ContactViewModel.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import Foundation
import EZSwiftExtensions
import RealmSwift
import Realm

class ContactViewModel {
    
    func getContacts(handler: @escaping (_ contacts: Results<Contact>?) -> Void) {
        
        let databaseContacts = DatabaseManager().getContacts()
        if databaseContacts.count > 0 {
            handler(databaseContacts)
        } else {
            Networker().downloadContacts { (contactsJSON, error) in
                
                if let contactArray = contactsJSON {

                    for dic in contactArray {
                        
                        let contact = Contact()
                        
                        let birthdateString = dic["born"] as? String ?? ""
                        let photoString = dic["photo"] as? String ?? ""
                        contact.name = dic["name"] as? String ?? ""
                        contact.email = dic["email"] as? String ?? ""
                        contact.birthdate = Date(fromString: birthdateString, format: "dd/MM/yyyy")
                        contact.bio = dic["bio"] as? String ?? ""
                        contact.photoURL = photoString
                        contact.id = self.generateUniqueId()
                        
                        DatabaseManager().save(contact: contact)
                    }
                    handler(DatabaseManager().getContacts())
                } else if let error = error {
                    
                    print(error.rawValue)
                    handler(nil)
                }
            }
        }
    }
    
    func generateUniqueId() -> String {
        // Semi-unique id
        // Created a method so it can be improved later
        return Date().timeIntervalSince1970.toString
    }
    
    func searchContacts(text: String) -> Results<Contact> {

        if text == "" {
            
            return DatabaseManager().getContacts()
        } else {
            
            return DatabaseManager().searchContacts(text: text)
        }
    }
    
    func add(contact: Contact) {
        
        DatabaseManager().save(contact: contact)
    }
    
    func remove(contact: Contact) {

        DatabaseManager().remove(contact: contact)
    }
}
