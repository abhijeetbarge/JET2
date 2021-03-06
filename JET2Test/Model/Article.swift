//
//  Article.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: String?
    let content: String?
    let comments: Int
    let likes: Int
    let media: [Media]?
    let user: [User]?
}

struct Media: Codable {
    let image: String?
    let title: String?
    let url: String?
}

