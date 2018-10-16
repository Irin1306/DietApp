//
//  HomeViewController.swift
//  DietApp
//
//  Created by USER on 13/10/2018.
//  Copyright © 2018 My. All rights reserved.
//
import Foundation
import UIKit

protocol ClassHVCDelegate: class {
    func onSignOut(completion: @escaping (_ data: (signedIn: Bool, userName: String)?) -> Void)
    func onSignIn()
}


class HomeViewController: UIViewController {
    
    // MARK: Privates
    var data: (signedIn: Bool, userName: String)?
    
    weak var delegate: ClassHVCDelegate?
    
    
    // MARK: - Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userData = data {
            print(userData)
            print(userData.userName)
            helloTextLabel.text = userData.signedIn ? "Hy, \(userData.userName )!" : "Hy, guest"
            
            navigationItem.rightBarButtonItem?.title = userData.signedIn ? "SignOut" : "SignIn"
        }
        
    }
    
    // MARK: - Action Handlers
    @IBOutlet weak var helloTextLabel: UILabel!
    
    @IBAction func onBackAction(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        
    }
   
    @IBAction func onLoginAction(_ sender: Any) {
        guard let userData = data else {return}
        if userData.signedIn {
           // print(delegate)
            delegate?.onSignOut{(data) in
                if  data != nil {
                    print(userData)
                    print(userData.userName)
                    self.helloTextLabel.text = "Hy, guest"
                    self.navigationItem.rightBarButtonItem?.title =  "SignIn"
                    self.data = data
                }
                
            }
        } else if !userData.signedIn {
            print(userData)
            
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
            delegate?.onSignIn()
        }
        
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
