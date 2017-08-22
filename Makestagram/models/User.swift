//
//  User.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

// This class holds the singleton for users and authentication for users

import Foundation

import FirebaseDatabase.FIRDataSnapshot

class User: NSObject {
    // store user uid and username
    let uid: String
    let username: String
    var isFollowed = false
    
    init (uid: String, username: String) {
        self.uid = uid
        self.username = username
        super.init()
    }
    
    // check if the user is in the database or not
    // if not, return nil
    init? (snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String

        else {
            return nil
        }

        self.uid = snapshot.key
        self.username = username
        super.init()
        
    }
    
    // if the user has already logged in, replace the uid and username values with the ones in userdefaults
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
        else {
            return nil
        }
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    // singleton for users
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error, user does not exist")
        }
        return currentUser
    }
    
    // set the uid and username in userdefaults
    // takes 2 paramenters, one is the current user and the other determines whether it should write to the userdefault or not.
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }
}

// nscoding protocol for user default
extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}
