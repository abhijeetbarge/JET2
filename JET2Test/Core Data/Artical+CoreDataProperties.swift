//
//  Artical+CoreDataProperties.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//
//

import Foundation
import CoreData


extension Artical {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artical> {
        return NSFetchRequest<Artical>(entityName: "Artical")
    }

    @NSManaged public var id: String?
    @NSManaged public var content: String?
    @NSManaged public var comments: Int64
    @NSManaged public var likes: Int64
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var designation: String?
    @NSManaged public var avatar: String?
    @NSManaged public var lastname: String?
    @NSManaged public var about: String?
    @NSManaged public var city: String?
    @NSManaged public var avatarData: Data?
    @NSManaged public var imageData: Data?
}
