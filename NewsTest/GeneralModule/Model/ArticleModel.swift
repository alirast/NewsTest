//
//  ArticleModel.swift
//  NewsTest
//
//  Created by N S on 14.07.2023.
//

import Foundation

struct NetworkManagerResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
