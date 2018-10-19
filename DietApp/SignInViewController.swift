//
//  SignInViewController.swift
//  DietApp
//
//  Created by USER on 16/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit


class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Publics
    var activeField: UITextField?
    
    // MARK: Privates
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
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
        passwordTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupUI()
        
    }
    
    // MARK: - Action Handlers
    @IBAction func onLogInAction(_ sender: Any) {
        FBAuthService.signInWithEmail(vc: self, email: emailTextField.text!, password: passwordTextField.text!){() in
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
            
        }
    }
    
    @IBAction func onResetAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let resetPwVC = mainStoryBoard.instantiateViewController(withIdentifier: "ResetPwViewController") as! ResetPwViewController
        navigationController?.pushViewController(resetPwVC, animated: true)
        
    }
    
    @IBAction func onSignUpAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    @IBAction func onFBSignInAction(_ sender: Any) {
        FBAuthService.signInWithFB(vc: self) {() in
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
            
        }
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
            passwordTextField.becomeFirstResponder()
            return false
            
        } else if textField.tag == 1 {
            textField.resignFirstResponder()
            return false
            
        }
        activeField = nil
        return true
        
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
        passwordTextField.text = " Password(min. 6 characters)"
        eyeButton.setImage(UIImage(named: "eyepassclose"), for: .normal)
        
        //colors
        emailTextField.textColor = UIColor.lightGray
        passwordTextField.textColor = UIColor.lightGray
        
        //fonts
        
        //states
        
        //actions
        
    }
    
    
    // MARK: - Delegates
    
}
