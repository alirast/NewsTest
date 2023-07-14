//
//  GeneralListPresenter.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import Foundation

protocol GeneralListViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol GeneralListViewPresenterProtocol: AnyObject {
    init(view: GeneralListViewProtocol, networkService: NetworkServiceProtocol)
    
    func getArticles()
    var articles: [Article]? { get set }
    var cellModels: [ListTableViewCellModel]? { get set }
}

class GeneralPresenter: GeneralListViewPresenterProtocol {
    weak var view: GeneralListViewProtocol?
    let networkService: NetworkServiceProtocol
    var articles: [Article]?
    var cellModels: [ListTableViewCellModel]?
    
    required init(view: GeneralListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getArticles()
    }
    
    func getArticles() {
        networkService.getArticles { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles
                    self.cellModels = articles?.compactMap({ ListTableViewCellModel(author: $0.author ?? "There's no author", title: $0.title, date: $0.publishedAt, imageURL: URL(string: $0.urlToImage ?? "")) }) ?? [ListTableViewCellModel]()
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
