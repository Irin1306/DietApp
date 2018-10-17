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
    
    
    var activeField: UITextField?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
   
    
    @IBAction func onSignUpAction(_ sender: Any) {
      
        guard
            let name = nameTextField.text,
            name != " Name" && name.count > 0
            else {
                addAlert(withTitle: "Sign Up", withMessage: "Please, fill in the field"){() in
                    //self.nameTextField.becomeFirstResponder()
                }
                return
           }
        
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let user = user {
                print(user)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.nameTextField.text!
                changeRequest?.commitChanges { (error) in
                    if let error = error {
                       print(error)
                    } else {
                        print("Profile updated")
                        // Profile updated.
                    }
                }
                
                // 3
                // Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                //                   password: self.textFieldLoginPassword.text!)
                
            }     
 
            
         }
 //
    }
     
    
    @IBAction func onLoginAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
      
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        emailTextField.text = " Email"
        emailTextField.textColor = UIColor.lightGray
        nameTextField.text = " Name"
        nameTextField.textColor = UIColor.lightGray
        passwordTextField.text = " Password(min. 6 characters)"
        passwordTextField.textColor = UIColor.lightGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    /*
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        activeView = textView
        //keyboardHeight may not be ready
        let textViewRealYPosition = keyboardHeight > 200 ? textView.frame.origin.y + textView.frame.height - keyboardHeight * offsetMultiplier :
            textView.frame.origin.y + textView.frame.height - 200 * offsetMultiplier
        
        if textView == textDescription {
            print(textViewRealYPosition)
            editScrollView.setContentOffset(CGPoint(x: 0, y: textViewRealYPosition), animated: true)
        }
        
        
    }
    */
  //  func textViewDidEndEditing(_ textView: UITextView) {
        
       // editScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
   // }
    
    
   
    
    func isValidEmailString(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" //"!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$/"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    func addAlert(withTitle title: String, withMessage message: String,
                  complition: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        // Add "OK" Button to alert, pressing it will bring you to the settings app
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            complition()
        }))
        // Show the alert with animation
        present(alert, animated: true, completion: nil)
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
            
               if isValidEmailString(emailStr: email) != true {
                addAlert(withTitle: "Sign Up", withMessage: "Invalid email field"){() in
                    //self.emailTextField.becomeFirstResponder()
                    }
                } else if password.count < 6 {
                    addAlert(withTitle: "Sign Up", withMessage: "Invalid password field"){() in
                       //self.nameTextField.becomeFirstResponder()
                    }
                }
                
        }
        
    }

}


