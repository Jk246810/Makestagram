//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/22/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {

    @IBAction func logIn(_ sender: UIButton) {
        // handle when users touch the sign in button
        print("login button touched")
        
        guard let authUI = FUIAuth.defaultAuthUI()
        else {
            return
        }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// handle login
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
        }
        
        guard let user = user
            else {
                return
        }

        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // set the current user to the current user in the class
                User.setCurrent(user, writeToUserDefaults: true)
                print("old user \(user.username)")
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toSignUp, sender: self)
            }
        }
    }
}
