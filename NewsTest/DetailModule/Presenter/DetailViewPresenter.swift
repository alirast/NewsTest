//
//  DetailViewPresenter.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setArticle(article: Article?)
    func showAlert(_ title: String)
}

protocol DetailViewPresenterProtocol: AnyObject {
    var article: Article? { get set }
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, article: Article?)
    func setArticle()
    func addToFavourite(link: String?)
    func addAuthor(author: String?)
    func addDescription(description: String?)
    func addImage(image: UIImage?)
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
    
    public func addAuthor(author: String?) {
        if let author = author {
            let isFavedAuthor = FavouriteListManager.shared.favAuthor.contains(author)
            if isFavedAuthor {
                FavouriteListManager.shared.removeAuthor(author)
                view?.showAlert("Убрано")
            } else {
                FavouriteListManager.shared.addFavAuthor(author)
                view?.showAlert("Добавлено")
            }
        }
    }
    
    public func addDescription(description: String?) {
        if let description = description {
            let isFavedDescription = FavouriteListManager.shared.favouritedNewsArray.contains(description)
            if isFavedDescription {
                FavouriteListManager.shared.removeNews(description)
                view?.showAlert("Убрано")
            } else {
                FavouriteListManager.shared.addFavouriteNews(description)
                view?.showAlert("Добавлено")
            }
        }
    }
    
    public func addImage(image: UIImage?) {
        if let image = image {
            let isFavedImage = FavouriteListManager.shared.favImage.contains(image)
            if isFavedImage {
                FavouriteListManager.shared.removeImage(image)
                view?.showAlert("Убрано")
            } else {
                FavouriteListManager.shared.addFavImage(image)
                view?.showAlert("Добавлено")
            }
        }
    }
}
