//
//  ArticleListTableViewController.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-20.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import UIKit

class ArticleListTableViewController: UITableViewController {
    
    var articles: [Article] = []
    let manager = ArticleManager()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.fetchArticles(.swiftNews) { [weak self] (articles) in
            self?.articles = articles
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        if let cell = cell as? ArticleTableViewCell {
            cell.configure(articles[indexPath.row])
        }
        return cell
    }
    
    @IBSegueAction private func showArticle(coder: NSCoder) -> ArticleViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
            return ArticleViewController(coder: coder, article: articles[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard ProcessInfo().operatingSystemVersion.majorVersion == 12 else { return }
        // only use this for backwards-compat with iOS 12, otherwise use segue actions (above method)
        if let controller = segue.destination as? ArticleViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            controller.article = articles[indexPath.row]
        }
    }
}

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleImageViewHeightConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageViewHeightConstraint.constant = 128.0
        articleImageView.image = nil
        titleLabel.text = nil
    }
    
    func configure(_ article: Article) {
        titleLabel.text = article.title
        if article.imageURL != nil {
            articleImageView.loadImage(article)
        } else {
            articleImageViewHeightConstraint.constant = 0
        }
    }
}
