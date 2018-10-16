//
//  SignInViewController.swift
//  DietApp
//
//  Created by USER on 16/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit
import Firebase
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


class SignInViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate{
    
   // let fbColor = UIColor.init(red:0.23, green:0.35, blue:0.60, alpha:1.0)
    
    @IBOutlet weak var fbSignInButton: UIButton!
    
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
    
        
        
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
        print("User Logged In")
        if ((error) != nil)
        {
            print(error.localizedDescription)
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("public_profile")
            {
                // Do work
                print(result)
                /*
                 let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                 Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                 if let error = error {
                 print("FB!!!!!!!!!!!!!!")
                 print(authResult)
                 return
                 }
                 // User is signed in
                 print("FB!!!!!!!!!!!!!!")
                 print(authResult)
                 }
                */
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
         let loginManager = FBSDKLoginManager()
         loginManager.logOut()
        
        
    }
    
    
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    /*
     @IBAction func onTapLoginWithFacebook(sender: AnyObject) {
     //1.
     let loginManager = FBSDKLoginManager()
     
     //2.
     let permissions = ["public_profile"]
     
     //3.
     let handler = { (result: FBSDKLoginManagerLoginResult!, error: NSError?) in
     if let error = error {
     //3.1
     print("error = \(error.localizedDescription)")
     } else if result.isCancelled {
     //3.2
     print("user tapped on Cancel button")
     } else {
     //3.3
     print("authenticate successfully")
     print(result)
     // self.goToHomeViewController()
     
     
     }
     }
     
     //4.
     loginManager.logIn(withReadPermissions: permissions, from: self, handler: handler as! FBSDKLoginManagerRequestTokenHandler)
     }
     
     
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
        
       

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
