//
//  CoreDataHelper.swift
//  Todo
//
//  Created by Quang Vu on 6/23/17.
//  Copyright © 2017 Quang Vu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    // ??
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // ??
    static let persistentContainer = appDelegate.persistentContainer
    // Data pool
    static let managedContext = persistentContainer.viewContext
    
    static func newTask() -> Task {
        // Create a new Task entity
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
        return task
    }
    
    static func saveTask() {
        // Save content
        do{
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func retrieveTask() -> [Task] {
        // Create a request
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do {
            // Fetch the data with created request
            let result = try managedContext.fetch(fetchRequest)
            return result
        }catch let error as NSError {
            print("Could not retrieve \(error)")
        }
        
        return []
    }
    
    static func deleteTask(task: Task) {
        managedContext.delete(task)
        saveTask()
    }
}
