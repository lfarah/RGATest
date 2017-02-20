//
//  Networker.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import Foundation
import Alamofire

//TODO: Explain: "MVVM and MVC share a common weakness: neither defines where the network logic of an app should go":  http://artsy.github.io/blog/2015/09/24/mvvm-in-swift/ 

struct Networker {
    
    func downloadContacts(handler: @escaping (_ contactsJSON: [[String: AnyObject]]) -> Void) {
        
        let url = Constants.baseURL + "content.json"
        Alamofire.request(url, parameters: [:], encoding: JSONEncoding.default).responseJSON { response in

            if let JSON = response.result.value as? [[String: AnyObject]] {
                
                handler(JSON)
            } else {
                print(response)
            }
        }

    }
}
