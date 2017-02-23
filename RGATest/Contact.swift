//
//  Contact.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Contact: Object {
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var birthdate: Date?
    dynamic var bio: String = ""
    dynamic var photoURL: String = ""
    dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
