//
//  ModuleBuilder.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

protocol Builder {
    static func createMainTabBarModule() -> UITabBarController
    static func createGeneralListViewController() -> UIViewController
    static func createFavouriteListViewController() -> UIViewController
    static func createDetailViewController(article: Article?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainTabBarModule() -> UITabBarController {
        let view = MainTabBarController()
        return view
        
    }
    
    static func createGeneralListViewController() -> UIViewController {
        let view = GeneralListViewController()
        let networkService = NetworkService()
        let presenter = GeneralPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createFavouriteListViewController() -> UIViewController {
        let view = FavouriteListViewController()
        return view
    }
    
    static func createDetailViewController(article: Article?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailViewPresenter(view: view, networkService: networkService, article: article)
        view.presenter = presenter
        return view
    }
    

}
