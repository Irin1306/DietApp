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
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        FBAuthService.reload(){() in
            print(FBAuthService.getCurrentUserName() as Any, FBAuthService.signedIn, FBAuthService.emailVerified)
            if FBAuthService.signedIn && FBAuthService.emailVerified {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let todayVC = mainStoryBoard.instantiateViewController(withIdentifier: "TodayCollectionViewController") as! TodayCollectionViewController
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                self.navigationController?.pushViewController(todayVC, animated: true)
                
            }            
        }
        
        navigationController?.isNavigationBarHidden = true
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }    
    
    // MARK: - Action Handlers
    @IBAction func onSignUpAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(signInVC, animated: true)
        
    }

}




