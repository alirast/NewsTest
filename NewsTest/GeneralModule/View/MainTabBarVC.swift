//
//  MainTabBarVC.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    let listViewController = ModuleBuilder.createGeneralListViewController()
    let favouriteViewController = ModuleBuilder.createFavouriteListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        listViewController.tabBarItem = UITabBarItem(title: "All", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
        favouriteViewController.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "star"), selectedImage: nil)
       
        
        viewControllers = [listViewController, favouriteViewController]
    }
}
