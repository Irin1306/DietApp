//
//  WelcomeViewController.swift
//  DietApp
//
//  Created by USER on 13/10/2018.
//  Copyright © 2018 My. All rights reserved.
//
import Foundation
import UIKit
import FirebaseUI

class WelcomeViewController: UIViewController, FUIAuthDelegate, ClassHVCDelegate {
    
    
    // MARK: Publics
    let clover = UIColor.init(red:0.01, green:0.52, blue:0.00, alpha:1.0)
    
    // MARK: Privates
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    private var signedIn = false
    
    // MARK: - Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        auth = Auth.auth()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth()
        ]
        
        authUI?.providers = providers
        
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                //self.loginAction(sender: self)
                return
            }
            // User is signed in.
            self.signedIn = true
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserSignedIn() {
            //showLoginView()
            print("!UserSignIn")
        }
        else {
            print("UserSignIn")
            self.signedIn = true
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(authStateListenerHandle!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Action Handlers
    @IBAction func onEnterAsGuestAction(_ sender: Any) {
        let tuple = (signedIn: false, userName: "")
        navigateToMainInterface(tuple)
        //performSegue(withIdentifier: "enterHomeTransition", sender: tuple)
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        // Present the default login view controller provided by authUI
        let authViewController = authUI?.authViewController();
        self.present(authViewController!, animated: true, completion: nil)
        
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        if signedIn {
            let tuple = (signedIn: true, userName: Auth.auth().currentUser!.displayName ?? "")
            navigateToMainInterface(tuple)
            //performSegue(withIdentifier: "enterHomeTransition", sender: tuple)
        } else {
            showLoginView()
        }
    }
    
    // MARK: - Public
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
        if (error != nil) {
            let errorCode = UInt((error! as NSError).code)
            
            switch errorCode {
            case FUIAuthErrorCode.userCancelledSignIn.rawValue:
                print("User cancelled sign-in");
                break
                
            default:
                let detailedError = (error! as NSError).userInfo[NSUnderlyingErrorKey] ?? error!
                print("Login error: \((detailedError as! NSError).localizedDescription)");
            }
        } else if (user != nil) {
            let tuple = (signedIn: true, userName: Auth.auth().currentUser!.displayName ?? "")
            navigateToMainInterface(tuple)
            //performSegue(withIdentifier: "enterHomeTransition", sender: tuple)
            
        }
    } 
    
    // MARK: - Private
    private func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        
        return true
    }
    
    private func showLoginView() {
        // let authViewController = authUI?.authViewController();
        // self.present(authViewController!, animated: true, completion: nil)
        if let authVC = authUI?.authViewController() {
            let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear]
            authVC.navigationBar.titleTextAttributes = textAttributes
            // authVC.navigationItem.title = " "
            authVC.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            
            present(authVC, animated: true, completion: nil)
        }
    }
   
    private func navigateToMainInterface(_ tuple: (signedIn: Bool, userName: String)) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
       
        let mainVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        mainVC.modalPresentationStyle = .custom
        mainVC.modalTransitionStyle = .flipHorizontal
        
        mainVC.data = tuple
        mainVC.delegate = self
        
        navigationController?.pushViewController(mainVC, animated: true)        
        
        /*
        guard let mainNavigationVC = mainStoryBoard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {return}
        
        //print(mainNavigationVC.topViewController)
        if let mainVC = mainNavigationVC.topViewController as? HomeViewController {
            //doesnt work
            //mainVC.modalPresentationStyle = .custom
            //mainVC.modalTransitionStyle = .flipHorizontal
            
            mainVC.data = tuple
            mainVC.delegate = self
        }
        
        present(mainNavigationVC, animated: true, completion: nil)
        */
    }
    
    // MARK: - Delegates
    func onSignOut(completion: @escaping ((signedIn: Bool, userName: String)?) -> Void) {
        // print(signedIn)
        do {
            try Auth.auth().signOut()
            signedIn = false
            print(signedIn)
            // self.dismiss(animated: true, completion: nil)
            let tuple = (signedIn: false, userName: "")
            completion(tuple)
        } catch let err {
            print(err)
        }
        
    }
    
    func onSignIn() {
        showLoginView()
    }
    
    // MARK: - Navigation
   /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let homeVC = segue.destination as! HomeViewController
        if let data = sender as? (signedIn: Bool, userName: String) {
            
            homeVC.data = data
            
        }
        
    }
    */

}

