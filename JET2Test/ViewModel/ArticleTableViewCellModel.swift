//
//  ArticleTableViewCellModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

class ArticleTableViewCellModel {

    private let article: Article

    init(article: Article) {
        self.article = article
    }

    var userName: String? {
        if let user = article.user, user.count > 0 {
            return user[0].name
        }
        return ""
    }
    var userDesignation: String? {
        if let user = article.user, user.count > 0 {
            return user[0].designation
        }
        return ""
    }

    var userLogoUrl: String? {
        if let user = article.user, user.count > 0 {
            return user[0].avatar
        }
        return ""
    }

    var id: String? {
        return article.id
    }
    var articleContent: String? {
        return article.content
    }
    var articleTitle: String? {
        if let media = article.media, media.count > 0 {
            return media[0].title
        }
        return ""
    }

    var articleUrl: String {
        if let media = article.media, media.count > 0 {
            return media[0].image ?? ""
        }
        return ""
    }

    var likes: String {
        return "\(article.likes/1000)K Likes"
    }
    
    var comment: String {
        return "\(article.comments/1000)K Comments"
    }
}
