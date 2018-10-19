//
//  WelcomeViewController.swift
//  DietApp
//
//  Created by USER on 13/10/2018.
//  Copyright © 2018 My. All rights reserved.
//
import Foundation
import UIKit


class WelcomeViewController: UIViewController {
    
    
    // MARK: Publics
   // var authStateDidChangeHandle: AuthStateDidChangeListenerHandle?
    
    // MARK: Privates
    // MARK: Outlets
    
    // MARK: - Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /*
        authStateDidChangeHandle = Auth.auth().addStateDidChangeListener({ auth, user in
            guard let user = user else { return }
            self.signedIn = true
            let isVerified = user.isEmailVerified
            self.emailVerified = isVerified
            print(self.emailVerified)
        })
         */
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        FBAuthService.reload()
        print(FBAuthService.signedIn, FBAuthService.emailVerified)        
      
        navigationController?.isNavigationBarHidden = true
        
    }
    
    
   // deinit {
      //  Auth.auth().removeStateDidChangeListener(authStateDidChangeHandle!)
        
   // }
 
    override func viewWillDisappear(_ animated: Bool) {
       // if let handle = authStateDidChangeHandle {
       //     print("handle")
        //    Auth.auth().removeStateDidChangeListener(handle)
       // }
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    // MARK: - Action Handlers
    @IBAction func onSignUpAction(_ sender: Any) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if FBAuthService.signedIn && FBAuthService.emailVerified {
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(homeVC, animated: true)
            
        } else {
            let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            navigationController?.pushViewController(signUpVC, animated: true)
            
        }
        
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if FBAuthService.signedIn && FBAuthService.emailVerified {
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(homeVC, animated: true)
            
        } else {
            let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            navigationController?.pushViewController(signInVC, animated: true)
            
        }
    }

}




