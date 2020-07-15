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
    private var articals: [Artical]?

    public func getArticals(pageNo: String,
                             completion: ((Bool) -> Void)?) {
        print("Fetching data for Page No : \(pageNo)")
        CoreDataManager.shared.clearStorage(forEntity: "Artical")
        networking.performNetworkTask(endpoint: JET2API.articles(pageNo: pageNo),
                                      type: [Artical].self) { [weak self] (response) in
                                        if response.count > 0 {
                                            if self?.articals == nil {
                                                self?.articals = response
                                            } else {
                                                self?.articals?.append(contentsOf:response )
                                            }
                                            completion?(true)
                                        }else{
                                            completion?(false)
                                        }
                                        
        }
    }
    
    
    func parseArticleJson(responseData:Data) {
        
        let decoder = JSONDecoder()
        let managedObjectContext = CoreDataManager.shared.managedObjectContext()
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve managed object context Key")
        }
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
        
        do {
            let result = try decoder.decode([Artical].self, from: responseData)
            self.articals = result
            print(result)
        } catch let error {
            print("decoding error: \(error)")
            
        }
        
        CoreDataManager.shared.clearStorage(forEntity: "Person")
        CoreDataManager.shared.saveContext()
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(paths[0])
        
        if self.articals?.count ?? 0 > 0 {
            let encoder = JSONEncoder()
            do {
                let encodedData = try encoder.encode(self.articals)
                print("Endoded data prints below")
                if let encodedString = String(data: encodedData, encoding: .utf8) {
                    print(encodedString)
                }
            } catch let err {
                print("encoding error \(err)")
            }
        }
    }
    
    

    public func cellViewModel(index: Int) -> ArticleTableViewCellModel? {
        guard let article = articals else { return nil }
        let articleTableViewCellModel = ArticleTableViewCellModel(article: article[index])
        return articleTableViewCellModel
    }
    
    public var count: Int {
        return articals?.count ?? 0
    }
    
    public func selectedUserProfile(index: Int) -> Artical? {
        return articals?[index]
    }
}
