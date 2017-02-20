//
//  ContactViewModel.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import Foundation
import EZSwiftExtensions

class ContactViewModel {
    
    var contacts: [Contact] = []
    func getContacts(handler: @escaping (_ contacts: [Contact]) -> Void) {
        
        Networker().downloadContacts { (contactsJSON) in
            
            var contacts: [Contact] = []
            for dic in contactsJSON {
                
                let name = dic["name"] as? String ?? ""
                let email = dic["email"] as? String ?? ""
                let birthdateString = dic["born"] as? String ?? ""
                let birthdate = Date(fromString: birthdateString, format: "dd/MM/yyyy")
                print(birthdateString)
                print(birthdate?.toString())
                let bio = dic["bio"] as? String ?? ""
                let photoString = dic["photo"] as? String ?? ""
                let photoURL = URL(string: photoString)!
                let contact = Contact(name: name, email: email, birthdate: birthdate, bio: bio, photoURL: photoURL)
                contacts.append(contact)
            }
            self.contacts = contacts
            handler(contacts)
        }
    }
    
    func searchContacts(text: String) -> [Contact] {
        
        if text == "" {
            return contacts
        } else {
            let filtered = contacts.filter { (Container) -> Bool in
                let range = Container.name.range(of: text, options: .caseInsensitive)
                return range != nil
            }
            return filtered
        }
    }
}
