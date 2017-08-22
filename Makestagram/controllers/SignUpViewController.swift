//
//  SignUpViewController.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create username in the database if the user is signing up
    @IBAction func signUpContinue(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
        let username = usernameTextField.text,
        !username.isEmpty
        else {
            return
        }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user
            else {
                return
            }
            // set the user to current user in the class
            User.setCurrent(user, writeToUserDefaults: true)
            
            print("create new user: \(user.username)")
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }

}
