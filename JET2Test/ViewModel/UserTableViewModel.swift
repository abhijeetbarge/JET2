//
//  UserTableViewModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

class UserTableViewModel {
    private let networking = Networking()
    private var users: [User]?
    
    public func getUsers(pageNo: String,
                         completion: ((Bool) -> Void)?) {
        print("Fetching data for Page No : \(pageNo)")
        networking.performNetworkTask(endpoint: JET2API.users(pageNo: pageNo),
                                      type: [User].self) { [weak self] (response) in
                                        if response.count > 0 {
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
    
    
    
    public func cellViewModel(index: Int) -> UserTableViewCellModel? {
        guard let user = users else { return nil }
        let userTableViewCellModel = UserTableViewCellModel(user: user[index])
        return userTableViewCellModel
    }
    
    public var count: Int {
        return users?.count ?? 0
    }
    
}
