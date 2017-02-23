//
//  Networker.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace

import Foundation
import Alamofire

// As this post explains, MVVM doesn't define where the network logic should go, so I created Networker to handle network calls
// http://artsy.github.io/blog/2015/09/24/mvvm-in-swift/ 

struct Networker {
    
    func downloadContacts(handler: @escaping (_ contactsJSON: [[String: AnyObject]]?, _ error: ServerError?) -> Void) {
        
        let url = Constants.baseURL + "content.json"
        Alamofire.request(url, parameters: [:], encoding: JSONEncoding.default).responseJSON { response in

            if let JSON = response.result.value as? [[String: AnyObject]] {
                
                handler(JSON, nil)
            } else {
                
                let error = ServerError.unexpectedResponse
                handler(nil, error)
            }
        }
    }
}
