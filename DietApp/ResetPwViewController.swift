//
//  ResetPwViewController.swift
//  DietApp
//
//  Created by USER on 19/10/2018.
//  Copyright © 2018 Irina. All rights reserved.
//

import UIKit

class ResetPwViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Publics
    
    // MARK: Privates
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupUI()
        
    }
    
    // MARK: - Action Handlers
    @IBAction func onResetPwAction(_ sender: Any) {
        FBAuthService.passwordReset(vc: self, email: emailTextField.text!)
        
    }
    
    // MARK: - Public
    func textField(_ textField: UITextField, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textFieldShouldReturn(textField)
            return false
            
        }
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return false
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            if textField == emailTextField {
                textField.text = " Email"
                
            }
            textField.textColor = UIColor.lightGray
            
        } else {
            guard
                let email = emailTextField.text
                else {return}
            
            if  ValidationService.isValidEmailString(emailStr: email) != true {
                AlertService.addAlertWithOutCancel(in: self, withTitle: nil, withMessage: "Please, enter valid email"){() in
                    self.emailTextField.becomeFirstResponder()
                }
            }
            
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        //names
        emailTextField.text = " Email"
        
        //colors
        emailTextField.textColor = UIColor.lightGray        
        
        //fonts
        
        //states
        
        //actions
        
    }
    
    
    // MARK: - Delegates

}
