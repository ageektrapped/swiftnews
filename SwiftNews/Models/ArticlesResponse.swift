//
//  ArticlesResponse.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-22.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation

struct ArticlesResponse: Codable {
    let kind: String
    var articles: [RedditArticle] {
        return data.children.map { $0.data }
    }
    let data: RedditArticleList
}

struct RedditArticleList: Codable {
    let children: [RedditPostType]
}

struct RedditPostType: Codable {
    let kind: String
    let data: RedditArticle
}

struct RedditArticle: Codable {
    let id: String
    let title: String
    let thumbnail: String
    let selftextHtml: String?
    let selftext: String
    let url: URL?
    
    var imageURL: URL? {
        guard thumbnail != "self", thumbnail != "default" else { return nil }
        return URL(string: thumbnail)
    }
}

extension Article {
    init(_ reddit: RedditArticle) {
        var body: String? = reddit.selftext
        if body?.isEmpty ?? false {
            body = reddit.url?.absoluteString
        }
        self.init(ArticleIdentifier(reddit.id),
                  title: reddit.title,
                  body: body,
                  image: reddit.imageURL)
    }
}
