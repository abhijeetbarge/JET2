//
//  CodingUserInfoKey+Util.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
