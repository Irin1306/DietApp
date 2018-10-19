//
//  FBAuthService.swift
//  DietApp
//
//  Created by USER on 18/10/2018.
//  Copyright © 2018 Irina. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
//import FBSDKShareKit


final class FBAuthService {
    
    private init() {}
    
    static var signedIn = false
    static var emailVerified = false
    
    static func getCurrentUserName() -> String?{
        return  Auth.auth().currentUser?.displayName
        
    }
    
    static func getCurrentUserEmailVerified() -> Bool?{
        return  Auth.auth().currentUser?.isEmailVerified
        
    }
    
    static func getCurrentUserProviderData() -> [String] {
        guard let providerData = Auth.auth().currentUser?.providerData else { return []}
        var provider: [String] = []
            for userInfo in providerData {
                switch userInfo.providerID {
                case "facebook.com":
                    print("user is signed in with facebook")
                    provider.append(userInfo.providerID)
                case "google.com":
                    print("user is signed in with google")
                    provider.append(userInfo.providerID)
                default:
                    print("user is signed in with \(userInfo.providerID)")
                    provider.append(userInfo.providerID)
                    
                }
                
            }
        
        return provider
    }
    
    static func reload(complition: @escaping () -> Void) {
        Auth.auth().currentUser?.reload(completion: { (error) in
            if error == nil{
                signedIn = true
                let provider = getCurrentUserProviderData()
                if provider.contains("facebook.com") {
                     emailVerified = true
                    
                } else {
                    if Auth.auth().currentUser!.isEmailVerified{
                        print("Verifed")
                        emailVerified = true
                        
                    } else {
                        print("It aint verified yet")
                        emailVerified = false
                        
                    }
                    
                }
                
                complition()
               
            } else {
                print(error?.localizedDescription as Any)
                signedIn = false
                emailVerified = false
                
            }
        })
        
    }
    
    static func signInWithEmail(vc: UIViewController, email: String, password: String,
                                complition: @escaping () -> Void) {
        reload(){() in
            print(getCurrentUserName() as Any, signedIn, emailVerified)
            }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print(error.localizedDescription)
                AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: error.localizedDescription){() in
                    //
                }
                return
                
            } else {
                let user = Auth.auth().currentUser
                if let user = user {
                    signedIn = true
                    if !user.isEmailVerified  {
                        AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: "Please, verify your email!"){() in
                            //
                        }
                        
                    } else  {
                        complition()
                        emailVerified = true
                        
                    }
                 }
            }
        }
    }
    
    static func signInWithFB(vc: UIViewController, complition: @escaping () -> Void) {
        let LoginManager = FBSDKLoginManager()
        LoginManager.logOut()
        LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: vc) { (result, error) in
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
            Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: error.localizedDescription){() in
                        //
                    }
                    return
                    
                } else {
                    if Auth.auth().currentUser != nil {
                        let user = Auth.auth().currentUser
                        if let user = user {
                            signedIn = true
                            emailVerified = true
                            complition()
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
   /*
    static func linkAccountWihtFacebook(){
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().currentUser?.linkAndRetrieveData(with: credential, completion: { (authResult, error) in
            
            if let LinkedUser = authResult{
                
                print("NEW USER:",LinkedUser.user.displayName as Any)
                
            }
            
            if let error = error as NSError?{
                //Indicates an attempt to link a provider of a type already linked to this account.
                if error.code == AuthErrorCode.providerAlreadyLinked.rawValue{
                    print("FIRAuthErrorCode.errorCodeProviderAlreadyLinked")
                }
                //This credential is already associated with a different user account.
                if error.code == 17025{
                    print("This credential is already associated with a different user account.")
                }
                
                print("MyError",error)
            }
            
        })
    }
    
    static func linkAccountWihtEmail(){
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.linkAndRetrieveData(with: credential, completion: { (authResult, error) in
            
            if let LinkedUser = authResult{
                
                print("NEW USER:",LinkedUser.user.displayName as Any)
                
            }
            
            if let error = error as NSError?{
                //Indicates an attempt to link a provider of a type already linked to this account.
                if error.code == AuthErrorCode.providerAlreadyLinked.rawValue{
                    print("FIRAuthErrorCode.errorCodeProviderAlreadyLinked")
                }
                //This credential is already associated with a different user account.
                if error.code == 17025{
                    print("This credential is already associated with a different user account.")
                }
                
                print("MyError",error)
            }
            
        })
    }
    */
    
    static func createUser(vc: UIViewController, email: String, password: String, name: String,
                           complition: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                //let nsError = (error as NSError)
                // Error: 17007 The email address is already in use by another account. ERROR_EMAIL_ALREADY_IN_USE
              //  if nsError.code == 17007{
               //     let credential = EmailAuthProvider.credential(withEmail: email, password: password)
               //     Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
               //         if let error = error {
               //             print(error.localizedDescription)
               //             return
               //         }
                        // User is signed in
               //         print("User is signed in")
               //     }
              //  }
                AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: error.localizedDescription){() in
                    //
                }
                return
                
            }
            else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { (error) in
                    if let error = error {
                        print(error)
                        
                    } else {
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if let error = error {
                                print(error)
                                
                            } else {
                                print("EmailVerification was sent")
                                signedIn = true
                                complition()
                                
                            }
                        }
                    }
                }                
                
            }
            
        }
    }
    
    static func passwordReset(vc: UIViewController, email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: error.localizedDescription){() in
                    //
                }
            } else {
                AlertService.addAlertWithOutCancel(in: vc, withTitle: nil, withMessage: "Reset email sent successfully, check your email"){() in
                    //
                }
                reload(){() in
                    print(getCurrentUserName() as Any, signedIn, emailVerified)
                }
            }
        }        
    }
    
    static func signOut(complition: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            signedIn = false
            emailVerified = false
            complition()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
        
    }
    
    
    
    
}
