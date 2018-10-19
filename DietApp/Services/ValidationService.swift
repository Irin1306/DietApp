//
//  ValidationService.swift
//  DietApp
//
//  Created by USER on 19/10/2018.
//  Copyright © 2018 Irina. All rights reserved.
//

import Foundation
 

class ValidationService {
    
    private init() {}   
    
    static func isValidEmailString(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
        
    }
    
}
