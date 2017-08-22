//
//  Post.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageUrl: String
    let imageHeight: CGFloat
    let creationDate: Date
    var likeCount: Int
    let poster: User
    var isLiked = false
    
    var dictValue: [String: Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid": poster.uid,
                        "username": poster.username]
        
        return ["image_url": imageUrl,
                "image_height": imageHeight,
                "created_at": createdAgo,
                "like_count": likeCount,
                "poster": userDict]
    }
    
    init(imageUrl: String, imageHeight: CGFloat) {
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current
    }
    
    // init for posts based on the user info object
    // this kind of init can be nil, if nil, it will use the init above
    init?(snapshot: DataSnapshot) {
        // data from the database
        guard let dict = snapshot.value as? [String: Any],
        let imageUrl = dict["image_url"] as? String,
        let imageHeight = dict["image_height"] as? CGFloat,
        let createdAgo = dict["created_at"] as? TimeInterval,
        let likeCount = dict["like_count"] as? Int,
        let userDict = dict["username"] as? [String: Any],
        let uid = userDict["uid"] as? String,
        let username = userDict["username"] as? String
        else {
            return nil
        }
        
        self.key = snapshot.key
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username)
    }
}
