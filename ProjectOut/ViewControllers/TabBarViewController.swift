//
//  TabBarViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewController = CollectionViewController()
        let favoriteViewController = FavoriteViewController()
        
        collectionViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
       favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let viewControllerList: [UIViewController] = [collectionViewController, favoriteViewController]
        setViewControllers(viewControllerList, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
