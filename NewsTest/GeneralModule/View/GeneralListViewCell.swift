//
//  GeneralListViewCell.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

class ListTableViewCellModel {
    let author: String
    let title: String
    let date: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(author: String, title: String, date: String, imageURL: URL?) {
        self.author = author
        self.title = title
        self.date = date
        self.imageURL = imageURL
    }
}

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let listAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let imageViewList: UIImageView = {
      let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listAuthorLabel)
        contentView.addSubview(imageViewList)
        contentView.addSubview(listTitleLabel)
        contentView.addSubview(dateLabel)
        
        listAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewList.translatesAutoresizingMaskIntoConstraints = false
        listTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            listAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            listAuthorLabel.trailingAnchor.constraint(equalTo: imageViewList.leadingAnchor, constant: -10),
                       
            listTitleLabel.topAnchor.constraint(equalTo: listAuthorLabel.bottomAnchor, constant: 10),
            listTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            listTitleLabel.trailingAnchor.constraint(equalTo: imageViewList.leadingAnchor, constant: -10),
                       
            dateLabel.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: imageViewList.leadingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                       
            imageViewList.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageViewList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageViewList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageViewList.widthAnchor.constraint(equalToConstant: 140)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listAuthorLabel.text = nil
        listTitleLabel.text = nil
        dateLabel.text = nil
        imageViewList.image = nil
    }
    
    func configure(with viewModel: ListTableViewCellModel) {
        listAuthorLabel.text = viewModel.author
        listTitleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        
        //image
        if let data = viewModel.imageData {
            imageViewList.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageViewList.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
