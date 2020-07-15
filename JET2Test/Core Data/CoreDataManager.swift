//
//  CoreDataManager.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    private override init() {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "JET2Test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func getDataForEntity(forEntity entity: String) ->[NSManagedObject]? {        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        do {
            let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            return result
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func getUserAvtarDataForEntity(forEntity entity: String, id: String) ->Data? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            if let result = try managedObjectContext.fetch(fetchRequest) as? [Users], result.count > 0 {
                return result[0].avatarData
            }else if let result = try managedObjectContext.fetch(fetchRequest) as? [Artical], result.count > 0 {
                return result[0].avatarData
            }
            
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func saveUserAvtarDataForEntity(forEntity entity: String, id: String, data:Data) {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            if let result = try managedObjectContext.fetch(fetchRequest) as? [Users], result.count > 0 {
                result[0].avatarData = data
            }else if let result = try managedObjectContext.fetch(fetchRequest) as? [Artical], result.count > 0 {
                result[0].avatarData = data
            }
            
        } catch let error as NSError {
            print(error)
        }
        self.saveContext()
    }
    
    
    func getArtcleMainImageDataForEntity(forEntity entity: String, id: String) ->Data? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
             if let result = try managedObjectContext.fetch(fetchRequest) as? [Artical], result.count > 0 {
                return result[0].imageData
            }
            
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func saveArtcleMainImageDataForEntity(forEntity entity: String, id: String, data:Data) {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
           if let result = try managedObjectContext.fetch(fetchRequest) as? [Artical], result.count > 0 {
                result[0].imageData = data
            }
            
        } catch let error as NSError {
            print(error)
        }
        self.saveContext()
    }
    
    func clearStorage(forEntity entity: String) {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let entities = try managedObjectContext.fetch(fetchRequest)
                for entity in entities {
                    managedObjectContext.delete(entity as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    
     func saveUsersToCoreData (users: [User]) {
        let moc = self.persistentContainer.viewContext
        moc.performAndWait {
        for user in users {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Users", into: moc) as! Users
            entity.id = user.id
            entity.about = user.about
            entity.avatar = user.avatar
            entity.city = user.city
            entity.designation = user.designation
            entity.lastname = user.lastname
            entity.name = user.name
        }
        self.saveContext()
        }
    }
    
     func saveArticlesToCoreData (articles: [Article]) {
        let moc = self.persistentContainer.viewContext
        moc.performAndWait {
            
            for article in articles {
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Artical", into: moc) as! Artical
                entity.id = article.id
                entity.content = article.content
                entity.comments = Int64(article.comments)
                entity.likes = Int64(article.likes)
                if let user = article.user, user.count>0 {
                    entity.name = user[0].name
                    entity.lastname = user[0].lastname
                    entity.about = user[0].about
                    entity.avatar = user[0].avatar
                    entity.city = user[0].city
                    entity.designation = user[0].designation
                }
                if let media = article.media, media.count>0 {
                    entity.image = media[0].image
                    entity.title = media[0].title
                    entity.url = media[0].url
                }
            }
            self.saveContext()
        }
    }
}
