//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/26/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let photoHelper = MGPhotoHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            // create the post for images
            PostService.create(for: image)
        }
    
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // trigger the taking/choosing photo action
            photoHelper.presentActionSheet(from: self)
            return false
        } else {
            return true
        }
    }
}
