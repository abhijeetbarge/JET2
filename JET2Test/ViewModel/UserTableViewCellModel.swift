//
//  UserTableViewCellModel.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

class UserTableViewCellModel {

    private let user: User

    init(user: User) {
        self.user = user
    }

    var id: String? {
        return user.id
    }
    var userName: String? {
        return user.name
    }
    var userDesignation: String? {
        return user.designation
    }

    var userLogoUrl: String {
       return user.avatar ?? ""
    }
    var userCity: String? {
       return user.city
    }
}
