//
//  ArticleTableViewCellModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

class ArticleTableViewCellModel {

    private let article: Artical

    init(article: Artical) {
        self.article = article
    }

    var userName: String? {
        return article.name
    }
    var userDesignation: String? {
        return article.designation
    }

    var userLogoUrl: String {
        return article.avatar ?? ""
    }

    var articleContent: String? {
        return article.content
    }
    var articleTitle: String? {
            return article.title
    }

    var articleUrl: String {
            return article.image ?? ""
    }

    var likes: String? {
        return "\(article.likes/1000)K Likes"
    }
    
    var comment: String? {
        return "\(article.comments/1000)K Comments"
    }
}
