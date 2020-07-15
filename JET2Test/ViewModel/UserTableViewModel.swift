//
//  UserTableViewModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UserTableViewModel {
    private let networking = Networking()
    private var users: [User]?
    
    public func getUsers(pageNo: String,
                         completion: ((Bool) -> Void)?) {
        print("Fetching data for Page No : \(pageNo)")
        networking.performNetworkTask(endpoint: JET2API.users(pageNo: pageNo),
                                      type: [User].self) { [weak self] (response) in
                                        if response.count > 0 {
                                            CoreDataManager.shared.saveUsersToCoreData(users: response)
                                            if self?.users == nil {
                                                self?.users = response
                                            } else {
                                                self?.users?.append(contentsOf:response )
                                            }
                                            completion?(true)
                                        }else{
                                            completion?(false)
                                        }
                                        
        }
    }
    
    
    func getUsersFromCoreData(completion: ((Bool) -> Void)) {
        var savedUsers = [User]()
        let allUsers = CoreDataManager.shared.getDataForEntity(forEntity: "Users") as? [Users]
        if let users = allUsers {
            for user in users {
                let usr = User(id:user.id, name: user.name, designation: user.designation, avatar: user.avatar, lastname: user.lastname, about: user.about, city: user.city,avatarData:user.avatarData )
                savedUsers.append(usr)
            }
        }
        self.users = savedUsers
        completion(true)
    }
    
    
    public func cellViewModel(index: Int) -> UserTableViewCellModel? {
        guard let user = users else { return nil }
        let userTableViewCellModel = UserTableViewCellModel(user: user[index])
        return userTableViewCellModel
    }
    
    public var count: Int {
        return users?.count ?? 0
    }
    
}
