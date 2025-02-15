//
//  CoreDataManager.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StudentApp")
        container.loadPersistentStores { (storeDescriptopn, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func resetAllData() {
           let context = persistentContainer.viewContext
           let entities = persistentContainer.managedObjectModel.entities
           
           for entity in entities {
               let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.name!)
               let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
               
               do {
                   try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
               } catch {
                   print("Failed to reset data: \(error)")
               }
           }
           
           UserDefaults.standard.set(false, forKey: "hasPopulatedInitialData")
           UserDefaults.standard.synchronize()
       }
}

