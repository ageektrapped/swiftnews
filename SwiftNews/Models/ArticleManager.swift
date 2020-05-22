//
//  ArticleManager.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-19.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation

class ArticleManager {
    private(set) var articles: [Article] = []
    private let networkManager = NetworkManager()
    
    func fetchArticles(_ request: ArticlesRequest, respond: @escaping ([Article]) -> Void) {
        networkManager.fetch(request.url) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(ArticlesResponse.self, from: data) {
                    DispatchQueue.main.async {
                        respond(response.articles.map { Article($0) })
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
