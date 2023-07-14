//
//  FavouriteListViewController.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

class FavouriteListViewController: UIViewController {

    var favouriteTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(favouriteTableView)
        favouriteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favouriteTableView.frame = view.bounds
    }
}

extension FavouriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell tapped")
        let selected = FavouriteListManager.shared.favLink[indexPath.row]
        print(selected)
        let selectedAuthor = FavouriteListManager.shared.favAuthor[indexPath.row]
        let selectedDescription = FavouriteListManager.shared.favouritedNewsArray[indexPath.row]
        let selectedImage = FavouriteListManager.shared.favImage[indexPath.row]
        

        
        let detailVC = ModuleBuilder.createDetailViewController(article: Article(source: Source(name: ""), author: selectedAuthor, title: "", description: selectedDescription, url: selected, urlToImage: nil, publishedAt: ""))
        navigationController?.pushViewController(detailVC, animated: true)
        favouriteTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavouriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouriteListManager.shared.favLink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        cell.textLabel?.text = FavouriteListManager.shared.favouritedNewsArray[indexPath.row]
        return cell
    }
}
