//
//  JET2API.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

enum JET2API {
    case articles(pageNo: String)
    case users(pageNo: String)
}

extension JET2API: EndpointType {
    var baseURL: URL {
        return URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/")!
    }

    var path: String {
        switch self {
        case .articles(let pageNo):
            return "blogs?page=\(pageNo)&limit=10"
        case .users(let pageNo):
            return "users?page=\(pageNo)&limit=10"
        }
    }
}
