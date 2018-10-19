//
//  HomeViewController.swift
//  DietApp
//
//  Created by USER on 13/10/2018.
//  Copyright © 2018 My. All rights reserved.
//
import Foundation
import UIKit



class HomeViewController: UIViewController {
    
    // MARK: Publics
    // MARK: Privates
    // MARK: Outlets
    @IBOutlet weak var helloTextLabel: UILabel!
    
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
        super.viewWillAppear(animated)
        if let userName = FBAuthService.getCurrentUserName() {
            helloTextLabel.text =  "Hi, \(userName )!"
            
        }
        
    }
    
    // MARK: - Action Handlers
    @IBAction func onBackAction(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func onSignOutAction(_ sender: Any) {
        FBAuthService.signOut(){() in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
     
    
}
