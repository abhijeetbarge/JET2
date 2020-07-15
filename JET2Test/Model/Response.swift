//
//  Response.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation
import CoreData

struct Response {
    fileprivate var data: Data
    fileprivate var articals: [Artical]?
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let error {
            print(error)
            return nil
        }
    }
    
    mutating func decodeAndSave<T: Codable>(_ type: T.Type) -> T? {
        let responseData = self.data
        let decoder = JSONDecoder()
        let managedObjectContext = CoreDataManager.shared.managedObjectContext()
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve managed object context Key")
        }
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
        
        do {
            let result = try decoder.decode(T.self, from: responseData)
            CoreDataManager.shared.saveContext()
            return result
        } catch let error {
            print("decoding error: \(error)")
            
        }
        return nil
    }
}
