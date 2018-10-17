//
//  SignInViewController.swift
//  DietApp
//
//  Created by USER on 16/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


//doesn't work
/*
 @IBDesignable extension GIDSignInButton {
 
 @IBInspectable var borderWidth: CGFloat {
 set {
 layer.borderWidth = newValue
 }
 get {
 return layer.borderWidth
 }
 }
 
 @IBInspectable var cornerRadius: CGFloat {
 set {
 layer.cornerRadius = newValue
 }
 get {
 return layer.cornerRadius
 }
 }
 
 @IBInspectable var borderColor: UIColor? {
 set {
 guard let uiColor = newValue else { return }
 layer.borderColor = uiColor.cgColor
 }
 get {
 guard let color = layer.borderColor else { return nil }
 return UIColor(cgColor: color)
 }
 }
 }
 */


class SignInViewController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {
    
   // let fbColor = UIColor.init(red:0.23, green:0.35, blue:0.60, alpha:1.0)
    
    var activeField: UITextField?
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLogInAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!,
                           password: passwordTextField.text!) { (user, error) in
           if let error = error {
               print(error.localizedDescription)
           }
           else if let user = user {
              print(user)
           }
                            
                            
        }
    }
    @IBAction func onResetAction(_ sender: Any) {
    }
    
    
    @IBAction func onSignUpAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    @IBAction func onFBSignInAction(_ sender: Any) {
            let LoginManager = FBSDKLoginManager()
            LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let accessToken = FBSDKAccessToken.current() else {
                    print("Failed to get access token")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                // Connecting Firebase APIs and login
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        let alertController = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
                        let permitAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(permitAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    } else {
                        if Auth.auth().currentUser != nil {
                     
                            let user = Auth.auth().currentUser
                            if let user = user {
                                // The user's ID, unique to the Firebase project.
                                // Do NOT use this value to authenticate with your backend server,
                                // if you have one. Use getTokenWithCompletion:completion: instead.
                                let uid = user.uid
                                let name = user.displayName
                                let email = user.email
                                let photoURL = user.photoURL
                                // ...
                                print("user")
                                print(uid, name, email, photoURL)
                            }
                        } else {
                            // No user is signed in.
                          print("No user is signed in")
                        }
                        
                    }
                   
                })
            }
    }
    
        
    /*
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
         let loginManager = FBSDKLoginManager()
         loginManager.logOut()
        
        
    }
    */
    
    /*
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
 */
    /*
     
     
     @IBAction func onTapLogoutButton(sender: AnyObject) {
     //log user out
     let loginManager = FBSDKLoginManager()
     loginManager.logOut()
     print("logoutFB")
     //go back to the Login screen
     // self.navigationController?.popViewControllerAnimated(true)
     }
     */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //google
       // GIDSignIn.sharedInstance().uiDelegate = self
       // GIDSignIn.sharedInstance().signIn()
        
        //fb
       // let loginButton = FBSDKLoginButton()
        // Optional: Place the button in the center of your view.
       // loginButton.center = view.center
       // view.addSubview(loginButton)
       // loginButton.delegate = self
       // if (FBSDKAccessToken.current() != nil) {
            // User is logged in, do work such as go to next view controller.
         //   print("loginFB")
       // }
        //loginButton.readPermissions = ["public_profile", "email"]
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        emailTextField.text = " Email"
        emailTextField.textColor = UIColor.lightGray       
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
