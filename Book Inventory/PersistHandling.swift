//
//  PersistHandling.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistHandling {
    //private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let container:NSPersistentContainer
    private let context:NSManagedObjectContext
    
    init () {
        
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error \(error)")
            }
        })
        //return container

        context = container.viewContext
    }
    
    public func AddRecord(_ title:String!, publisher:String!, author:String!, publish_date:String!) -> Bool {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: context)
        let newBook = NSManagedObject(entity: entity!, insertInto: context)
        
        newBook.setValue(title, forKey: "title")
        newBook.setValue(publisher, forKey: "publisher")
        newBook.setValue(author, forKey: "author")
        newBook.setValue(publish_date, forKey: "publish_date")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
            return false
        }
        return true
    }
    
    public func getRecords() -> [(title:String?, publisher:String?, author:String?, publish_date:String?)] {
        
        var books = [(String?, String?, String?, String?)]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                //print(data.value(forKey: "username") as! String)
                let title = data.value(forKey:"title") as? String
                let publisher = data.value(forKey:"publisher") as? String
                let author = data.value(forKey:"author") as? String
                let publish_date = data.value(forKey: "publish_date") as? String

                books.append((title,publisher, author, publish_date))
            }
            
        } catch {
            print("Failed")
        }
        return books
    }
}
