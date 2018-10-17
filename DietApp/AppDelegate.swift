//
//  AppDelegate.swift
//  DietApp
//
//  Created by USER on 16/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
//import FBSDKShareKit
//import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    //let clover = UIColor.init(red:0.01, green:0.52, blue:0.00, alpha:1.0)
    //let tangerine = UIColor.init(red:0.95, green:0.52, blue:0.00, alpha:0.6)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
        // FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
       // let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Sets background to a blank/empty image
       // UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
      //  UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
       // UINavigationBar.appearance().backgroundColor = tangerine//.clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        //UINavigationBar.appearance().isTranslucent = false
        
      //  UIApplication.shared.statusBarView?.backgroundColor = tangerine
      //  UIApplication.shared.statusBarView?.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        // UIApplication.shared.statusBarStyle = .lightContent
      //  UINavigationBar.appearance().barTintColor = tangerine
     //   UINavigationBar.appearance().tintColor = UIColor.white
      //  UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        return true
    }
    
    //MARK: GoogleAuth
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    //iOS 8.0 and older
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            // User is signed in
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            print(userId, idToken, fullName, givenName, familyName, email)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("user disconnects")
    }
    //
    
    //Facebook
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        //2.
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        
        return handled
    }
    
    /*
     //iOS 8.0 and older
     func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
     
     let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
     // Add any custom logic here.
     return handled
     }
     */
    /*
     func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
     if let error = error {
     print(error.localizedDescription)
     return
     }
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
     
     }
     
     func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
     //log user out
     let loginManager = FBSDKLoginManager()
     loginManager.logOut()
     print("logoutFB")
     //go back to the Login screen
     // self.navigationController?.popViewControllerAnimated(true)
     }
     */
    //
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
}


/*
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
*/

