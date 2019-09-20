//
//  CoreManager.swift
//  ProjectOut
//
//  Created by Consultant on 9/18/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation
import CoreData

class CoreManager {
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProjectOut")
        container.loadPersistentStores(completionHandler: {(storeDescrip, err) in
            if let error = err {
                fatalError()
            }
        })
        return container
    }()
    func save (_ image: Image) {
        let entity = NSEntityDescription.entity(forEntityName: "CoreData", in: context)!
        let coreData = NSManagedObject(entity: entity, insertInto: context)
        coreData.setValue(image.thumbnailUrl, forKey: "thumbnailUrl")
        coreData.setValue(image.url, forKey: "url")
        coreData.setValue(image.title, forKey: "title")
        print("Saved Image")
        saveContext()
    }
    func remove (_ image: Image) {
     let fetchRequest = NSFetchRequest<CoreData>(entityName: "CoreData")
        let predicate = NSPredicate(format: "title==%@", image.title)
        fetchRequest.predicate = predicate
        var coreData = [CoreData]()
        do {
            coreData = try context.fetch(fetchRequest)
        } catch {
            print("Could not fetch images")
        }
        for core in coreData {
            print("Delete Image")
            context.delete(core)
        }
        saveContext()
    }
    func reload() -> [Image] {
        
        let fetchRequest = NSFetchRequest<CoreData>(entityName: "CoreData")
        
        var images = [Image]()
        
        do {
            let coreData = try context.fetch(fetchRequest)
            
            coreData.forEach({images.append(Image(from: $0 ))})
            
        } catch {
            print("Could not fetch Image")
        }
        return images
    }
    
    private func saveContext () {
        do {
            try context.save()
        } catch {
            print("Could not save to CoreData")
        }
    }
}
