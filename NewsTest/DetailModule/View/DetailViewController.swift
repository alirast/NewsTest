//
//  DetailViewController.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailNewsImageView = UIImageView()
    var detailAuthorLabel = UILabel()
    var detailDescriptionLabel = UILabel()
    var detailLinkLabel = UILabel()
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavourite))
        
        setupDetailImage()
        setupDetailAuthor()
        setupDetailDescription()
        setupDetailLink()
        presenter.setArticle()
    }
    
    func setupDetailImage() {
        detailNewsImageView.translatesAutoresizingMaskIntoConstraints = false
        detailNewsImageView.backgroundColor = .black
        
        view.addSubview(detailNewsImageView)
        NSLayoutConstraint.activate([
            detailNewsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            detailNewsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailNewsImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            detailNewsImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        detailNewsImageView.contentMode = .scaleAspectFill
        detailNewsImageView.center = view.center
        
    }
    
    func setupDetailAuthor() {
        detailAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        detailAuthorLabel.textColor = .black
        detailAuthorLabel.font.withSize(30)
        view.addSubview(detailAuthorLabel)
        NSLayoutConstraint.activate([
            detailAuthorLabel.topAnchor.constraint(equalTo: detailNewsImageView.bottomAnchor, constant: 10),
            detailAuthorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailAuthorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setupDetailDescription() {
        detailDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        detailDescriptionLabel.textColor = .black
        detailDescriptionLabel.sizeToFit()
        detailDescriptionLabel.numberOfLines = 0
        view.addSubview(detailDescriptionLabel)
        NSLayoutConstraint.activate([
            detailDescriptionLabel.topAnchor.constraint(equalTo: detailAuthorLabel.bottomAnchor, constant: 10),
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
        ])
    }
    
    func setupDetailLink() {
        detailLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLinkLabel.numberOfLines = 0
        detailLinkLabel.sizeToFit()
        detailLinkLabel.textColor = .black
        view.addSubview(detailLinkLabel)
        NSLayoutConstraint.activate([
            detailLinkLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            detailLinkLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailLinkLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    @objc func addToFavourite() {
        print("added to favourite")
        presenter.addToFavourite(link: detailLinkLabel.text)
        
      
    }
    
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: "\(title)", message: nil, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            alert.dismiss(animated: true)
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func setArticle(article: Article?) {
        detailAuthorLabel.text = article?.author
        detailDescriptionLabel.text = article?.description
        detailLinkLabel.text = article?.url
        if let imageURL = URL(string: article?.urlToImage ?? "") {
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.detailNewsImageView.image = image
                    }
                }
            }
        }
    }
}


