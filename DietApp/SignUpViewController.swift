//
//  SignUpViewController.swift
//  DietApp
//
//  Created by USER on 16/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Publics
    var activeField: UITextField?
    
    // MARK: Privates
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var eyeButton: UIButton!
    
    
    // MARK: - Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupUI()
        
    }
    
    // MARK: - Action Handlers
    @IBAction func onSignUpAction(_ sender: Any) {
        guard
            let name = nameTextField.text,
            name != " Name" && name.count > 0
            else {
                AlertService.addAlertWithOutCancel(in: self, withTitle: nil, withMessage: "Please, fill in the field"){() in
                    //self.nameTextField.becomeFirstResponder()
                }
                return
        }
        FBAuthService.createUser(vc: self, email: emailTextField.text!, password: passwordTextField.text!, name: nameTextField.text!){() in
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.navigationController?.pushViewController(signInVC, animated: true)
            
        }
    }
    
    @IBAction func onLoginAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    @IBAction func onShowPasswordAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !(passwordTextField.isSecureTextEntry)
        let image = passwordTextField.isSecureTextEntry ? UIImage(named: "eyepassclose") : UIImage(named: "eyepassopen")       
        eyeButton.setImage(image, for: .normal)
        
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
        if textField.tag == 0 {
            nameTextField.becomeFirstResponder()
            return false
            
        } else if textField.tag == 1 {
            passwordTextField.becomeFirstResponder()
            return false
            
        } else if textField.tag == 2 {
            textField.resignFirstResponder()
            return false
            
        }
        activeField = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)!  {
            if textField == emailTextField {
                textField.text = " Email"
                
            } else if textField == nameTextField {
                textField.text = " Name"
                
            } else if textField == passwordTextField {
                textField.text = " Password(min. 6 characters)"
                
            }
            textField.textColor = UIColor.lightGray
            
        } else {
            guard
                let email = emailTextField.text,
                let password = passwordTextField.text
                else {return}
            
            if ValidationService.isValidEmailString(emailStr: email) != true {
                AlertService.addAlertWithOutCancel(in: self, withTitle: nil, withMessage: "Please, enter valid email"){() in
                    //self.emailTextField.becomeFirstResponder()
                }
                
            } else if password.count < 6 {
                AlertService.addAlertWithOutCancel(in: self, withTitle: nil, withMessage: "Please, enter valid password"){() in
                    //self.nameTextField.becomeFirstResponder()
                }
                
            }
            
        }
        
    }
    
    // MARK: - Private
    private func setupUI() {
        //names
        emailTextField.text = " Email"
        nameTextField.text = " Name"
        passwordTextField.text = " Password(min. 6 characters)"
        eyeButton.setImage(UIImage(named: "eyepassclose"), for: .normal)
        
        //colors
        emailTextField.textColor = UIColor.lightGray
        nameTextField.textColor = UIColor.lightGray
        passwordTextField.textColor = UIColor.lightGray
        
        //fonts
        
        //states
        
        //actions
        
    }
    
    
    // MARK: - Delegates   
    
    

}


