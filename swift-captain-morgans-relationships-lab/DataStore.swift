//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Sergey Nevzorov on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var pirates: [Pirate] = []
    var ships: [Ship] = []
    var engine: [Engine] = []
    
    static let sharedDataStore = DataStore()
    
    // MARK: - Core Data stack
    
    
    func fetchData() {
        
        var error: NSError? = nil
        let pirateRequest = NSFetchRequest.init(entityName: "Pirate")
        let pirateName = NSSortDescriptor(key: "name", ascending: true)
        pirateRequest.sortDescriptors = [pirateName]
        
        do {
            pirates = try managedObjectContext.executeFetchRequest(pirateRequest) as! [Pirate]
        } catch let nserror1 as NSError {
            error = nserror1
            print("error occured \(error)")
            pirates = []
        }
        
        if pirates.count == 0 {
            self.generateTestData()
            self.saveContext()
            self.fetchData()
        }
    }
    
    func generateTestData() {
        
        ///Engine///
        let engineOne: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineOne.gas = "Regular Oil"
        
        
        let engineTwo: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
            engineTwo.gas = "People's labor"
        
        let engineThree: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        engineThree.gas = "Electricity"
        
        ///Ships///
        let shipOne: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipOne.name = "Santa Sara"
        shipOne.engine = engineOne
        
        let shipTwo: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipTwo.name = "Eclipse"
        shipTwo.engine = engineTwo
        
        let shipThree: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        shipThree.name = "Lucky"
        shipThree.engine = engineThree
        
        ///Pirates///
        let pirateOne: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        pirateOne.name = "Blind Bob"
        pirateOne.ships?.insert(shipOne)
        
        let pirateTwo: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        pirateTwo.name = "Dirty Billy"
        pirateTwo.ships?.insert(shipTwo)
        pirateTwo.ships?.insert(shipThree)
        
        
        
    }
    
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.first.test" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}