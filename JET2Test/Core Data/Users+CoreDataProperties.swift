//
//  Users+CoreDataProperties.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var designation: String?
    @NSManaged public var avatar: String?
    @NSManaged public var lastname: String?
    @NSManaged public var about: String?
    @NSManaged public var city: String?
    @NSManaged public var avatarData: Data?

}
