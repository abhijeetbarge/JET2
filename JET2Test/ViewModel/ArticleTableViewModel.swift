//
//  ArticleTableViewModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

class ArticleTableViewModel {

    private let networking = Networking()
    private var articles: [Article]?

    public func getArticals(pageNo: String,
                             completion: ((Bool) -> Void)?) {
        print("Fetching data for Page No : \(pageNo)")
        networking.performNetworkTask(endpoint: JET2API.articles(pageNo: pageNo),
                                      type: [Article].self) { [weak self] (response) in
                                        if response.count > 0 {
                                            if self?.articles == nil {
                                                self?.articles = response
                                            } else {
                                                self?.articles?.append(contentsOf:response )
                                            }
                                            completion?(true)
                                        }else{
                                            completion?(false)
                                        }
                                        
        }
    }

    public func cellViewModel(index: Int) -> ArticleTableViewCellModel? {
        guard let article = articles else { return nil }
        let articleTableViewCellModel = ArticleTableViewCellModel(article: article[index])
        return articleTableViewCellModel
    }
    
    public var count: Int {
        return articles?.count ?? 0
    }

    public func selectedUserLogin(index: Int) -> String {
        return  ""
    }
}
