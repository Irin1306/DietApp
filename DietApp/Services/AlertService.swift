//
//  AlertService.swift
//  DietApp
//
//  Created by USER on 18/10/2018.
//  Copyright © 2018 Irina. All rights reserved.
//
import Foundation
import UIKit

class AlertService {
    
    private init() {}
    
    static func addAlertWithCancel(in vc: UIViewController, withTitle title: String?, withMessage message: String?,
                         complition: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            complition()
        }))
      
        vc.present(alert, animated: true)
    }
    
    static func addAlertWithOutCancel(in vc: UIViewController, withTitle title: String?, withMessage message: String?,
                                   complition: @escaping () -> Void) {        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            complition()
        }))
        
        vc.present(alert, animated: true)
    }
    
}
