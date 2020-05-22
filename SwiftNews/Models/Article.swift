//
//  Article.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-19.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation

struct ArticleIdentifier: Equatable, Hashable, RawRepresentable, ExpressibleByStringLiteral {
    typealias RawValue = String
    typealias StringLiteralType = String
    
    let rawValue: String
    
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    init(stringLiteral value: String) {
        self.rawValue = value
    }
    
    init(_ value: String) {
        self.rawValue = value
    }
}

struct Article {
    let identifier: ArticleIdentifier
    let title: String?
    let body: String?
    let imageURL: URL?
    
    init(_ identifier: ArticleIdentifier,
         title: String?,
         body: String?,
         image: URL? = nil) {
        self.identifier = identifier
        self.title = title
        self.body = body
        self.imageURL = image
    }
}

extension Article {
    static let empty = Article("empty", title: nil, body: nil)
}
