//
//  ArticlesRequest.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-19.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation

struct ArticlesRequest {
    let url: URL?
}

extension ArticlesRequest {
    static var swiftNews: ArticlesRequest {
        ArticlesRequest(url: URL(string: "https://www.reddit.com/r/swift/.json")!)
    }
}
