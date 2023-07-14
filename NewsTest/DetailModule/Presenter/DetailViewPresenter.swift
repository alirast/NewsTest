//
//  DetailViewPresenter.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setArticle(article: Article?)
    func showAlert(_ title: String)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, article: Article?)
    func setArticle()
    func addToFavourite(link: String?)
    func addToFavour(article: Article?)
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var article: Article?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, article: Article?) {
        self.view = view
        self.networkService = networkService
        self.article = article
    }
    
    public func setArticle() {
        self.view?.setArticle(article: article)
    }
    
    public func addToFavour(article: Article?) {
        print("article\(article)")
    }
    
    public func addToFavourite(link: String?) {
        if let link = link {
            print("added in presenter \(link)")
            let isFavedLink = FavouriteListManager.shared.favLink.contains(link)
            print(isFavedLink)
            
            if isFavedLink {
                FavouriteListManager.shared.removeLink(link)
                view?.showAlert("Убрано")
            } else {
                FavouriteListManager.shared.addFavLink(link)
                view?.showAlert("Добавлено")
            }
        }
    }
}
