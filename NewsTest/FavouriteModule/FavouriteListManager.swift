//
//  FavouriteListManager.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import UIKit

class FavouriteListManager {
    static let shared = FavouriteListManager()
    var favouritedNewsArray: [String] = []
    
    var favLink: [String] = []
    var favAuthor: [String] = []
    var favImage: [UIImage] = []
    
    
    let defaults = UserDefaults.standard
    let favouritedNewsKey = "favouritedNewsKey"
    
    let favLinkKey = "favLinkKey"
    let favAuthorKey = "favAuthorKey"
    let favImageKey = "favImageKey"
    
    init() {
        if let savedFavourites = defaults.object(forKey: favouritedNewsKey) as? [String] {
            favouritedNewsArray = savedFavourites
        }
        if let savedLink = defaults.object(forKey: favLinkKey) as? [String] {
            favLink = savedLink
        }
        
        if let savedAuthor = defaults.object(forKey: favAuthorKey) as? [String] {
            favAuthor = savedAuthor
        }
        
        if let savedImage = defaults.object(forKey: favImageKey) as? [Data] {
            favImage = savedImage.compactMap({ UIImage(data: $0) })
        }
    }
    
    func addFavLink(_ link: String) {
        favLink.append(link)
        saveLink()
    }
    
    func addFavAuthor(_ author: String) {
        favAuthor.append(author)
        saveAuthor()
    }
    
    func addFavImage(_ image: UIImage) {
        favImage.append(image)
        saveImage()
    }

    func addFavouriteNews(_ news: String) {
        favouritedNewsArray.append(news)
        saveFavouriteNews()
    }
    
    func removeNews(_ news: String) {
        if let index = favouritedNewsArray.firstIndex(of: news) {
            favouritedNewsArray.remove(at: index)
            saveFavouriteNews()
        }
    }
    
    func removeLink(_ link: String) {
        if let index = favLink.firstIndex(of: link) {
            favLink.remove(at: index)
            saveLink()
        }
    }
    
    func removeImage(_ image: UIImage) {
        if let index = favImage.firstIndex(of: image) {
            favImage.remove(at: index)
            saveImage()
        }
    }
    
    private func saveLink() {
        defaults.set(favLink, forKey: favLinkKey)
    }
    
    private func saveImage() {
        let imageData = favImage.compactMap({ $0.jpegData(compressionQuality: 1.0) })
        defaults.set(imageData, forKey: favImageKey)
    }
    
    func removeAuthor(_ author: String) {
        if let index = favAuthor.firstIndex(of: author) {
            favAuthor.remove(at: index)
            saveAuthor()
        }
    }
    
    private func saveAuthor() {
        defaults.set(favAuthor, forKey: favAuthorKey)
    }
    
    private func saveFavouriteNews() {
        defaults.set(favouritedNewsArray, forKey: favouritedNewsKey)
    }
}
