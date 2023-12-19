//
//  News.swift
//  NewsApp
//
//  Created by Huseyin on 19/12/2023.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}


