//
//  ArticleViewController.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-20.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    init(coder: NSCoder, article: Article) {
        self.article = article
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        self.article = .empty
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = article.title
        textView.text = article.body
        if article.imageURL != nil {
            imageView.loadImage(article)
        } else {
            imageHeightConstraint.constant = 0
        }
    }
}
