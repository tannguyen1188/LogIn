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
        let collNav = UINavigationController(rootViewController: collectionViewController)
        let favsNav = UINavigationController(rootViewController: favoriteViewController)
        
        collectionViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
       favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let viewControllerList: [UIViewController] = [collNav, favsNav]
        setViewControllers(viewControllerList, animated: false)
    }
}
