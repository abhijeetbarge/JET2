//
//  Article.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: String
    let createdAt: String
    let content: String
    let comments: Int
    let likes: Int
    let media: [Media]?
    let user: [User]?
}

struct Media: Codable {
    let image: String
    let title: String
    let url: String
}


import CoreData
class Artical: NSManagedObject, Codable {
    
   //@NSManaged var id: String
   @NSManaged var content: String?
   @NSManaged var comments: Int64
   @NSManaged var likes: Int64
   //@NSManaged var media: [Media]?
   @NSManaged var image: String?
   @NSManaged var title: String?
   @NSManaged var url: String?
   
   //@NSManaged var user: [User]?
   @NSManaged var name: String?
   @NSManaged var designation: String?
   @NSManaged var avatar: String?
   @NSManaged var lastname: String?
   @NSManaged var about: String?
   @NSManaged var city: String?
    
    enum CodingKeys: String, CodingKey {
        //case id
        case content
        case comments
        case likes
        
        case media
        case image
        case title
        case url
        
        case user
        case name
        case designation
        case avatar
        case lastname
        case about
        case city
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Artical", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        //id = try container.decode(String.self, forKey: .id)
        //name = try container.decode(String.self, forKey: .name)
        
        content = try container.decode(String.self, forKey: .content)
        comments = try container.decode(Int64.self, forKey: .comments)
        likes = try container.decode(Int64.self, forKey: .likes)
        
        var media1 = try container.nestedUnkeyedContainer(forKey: .media)
        
        let media = try media1.nestedContainer(keyedBy: CodingKeys.self)
        
        //let media = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .media)
        image = try media.decode(String.self, forKey: .image)
        title = try media.decode(String.self, forKey: .title)
        url = try media.decode(String.self, forKey: .url)
        
        
        //let user = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        var user1 = try container.nestedUnkeyedContainer(forKey: .user)
        let user = try user1.nestedContainer(keyedBy: CodingKeys.self)


        name = try user.decode(String.self, forKey: .name)
        designation = try user.decode(String.self, forKey: .designation)
        avatar = try user.decode(String.self, forKey: .avatar)
        lastname = try user.decode(String.self, forKey: .lastname)
        about = try user.decode(String.self, forKey: .about)
        city = try user.decode(String.self, forKey: .city)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        var media = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .media)
        try media.encode(image, forKey: .image)
        try media.encode(title, forKey: .title)
        try media.encode(url, forKey: .url)
        
        var user = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        try user.encode(name, forKey: .name)
        try user.encode(designation, forKey: .designation)
        try user.encode(avatar, forKey: .avatar)
        try user.encode(city, forKey: .city)
        try user.encode(about, forKey: .about)
        try user.encode(lastname, forKey: .lastname)
    }
}
