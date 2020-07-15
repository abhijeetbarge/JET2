//
//  ArticleTableViewModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ArticleTableViewModel {

    private let networking = Networking()
    private var articles: [Article]?

    
    func getArticalsFromCoreData(completion: ((Bool) -> Void)) {
        var savedArtcles = [Article]()
        let allArticals = CoreDataManager.shared.getDataForEntity(forEntity: "Artical") as? [Artical]
        if let articals = allArticals {
            for artical in articals {
                let media = Media(image: artical.image, title: artical.title, url: artical.url)
                let user = User(id: artical.id, name: artical.name, designation: artical.designation, avatar: artical.avatar, lastname: artical.lastname, about: artical.about, city: artical.city,avatarData:nil)
                
                let article = Article(id: artical.id, content: artical.content, comments: Int(artical.comments), likes: Int(artical.likes), media: [media], user: [user])
                savedArtcles.append(article)
            }
        }
        self.articles = savedArtcles
        completion(true)
    }
    
    
    public func getArticals(pageNo: String,
                             completion: ((Bool) -> Void)?) {
        print("Fetching data for Page No : \(pageNo)")
        if pageNo == "1" {
            CoreDataManager.shared.clearStorage(forEntity: "Artical")
        }
        networking.performNetworkTask(endpoint: JET2API.articles(pageNo: pageNo),
                                      type: [Article].self) { [weak self] (response) in
                                        if response.count > 0 {
                                            CoreDataManager.shared.saveArticlesToCoreData(articles: response)
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
    
    public func selectedUserProfile(index: Int) -> Article? {
        return articles?[index]
    }
}
