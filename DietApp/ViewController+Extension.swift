//
//  ViewController+Extension.swift
//  DietApp
//
//  Created by USER on 17/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(hideKeyboard))
        
        tap.cancelsTouchesInView=false
        view.addGestureRecognizer(tap)
    }
    @objc func hideKeyboard() {
        
        view.endEditing(true)
        
    }
    
}
