//
//  Notifier.swift
//  RGATest
//
//  Created by Lucas Farah on 12/7/16.
//  Copyright © 2016 Awesome Labs. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SCLAlertView

class Notifier: AnyObject {
    
    func localAlertError(error: String) {
        
        _ = SCLAlertView().showError("Oops", subTitle: error, closeButtonTitle: "OK")
    }
    
    func localAlert(message: String) {
        
        _ = SCLAlertView().showSuccess("Sucesso", subTitle: message, closeButtonTitle: "OK")
    }
    
}
