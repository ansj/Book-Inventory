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
    public func AddRecord() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: context)
        let newBook = NSManagedObject(entity: entity!, insertInto: context)
        
        newBook.setValue("Shashikant", forKey: "username")
        newBook.setValue("1234", forKey: "password")
        newBook.setValue("1", forKey: "age")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        return true
    }
}
