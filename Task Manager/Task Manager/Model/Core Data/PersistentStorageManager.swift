//
//  PersistentStorageManager.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit
import CoreData

class PersistentStorageManager {
    
    static let shared = PersistentStorageManager()
    
    private init() {}
    
    public func saveTask(with id: Int32?, title: String, date: Date?, categoryName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        if let taskID = id {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            fetchRequest.predicate = NSPredicate(format: "id = %d", taskID)
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                if !result.isEmpty {
                    
                    let taskToUpdate = result[0] as! Task
                    taskToUpdate.title = title
                    taskToUpdate.completionDate = date
                    for category in PersistentStorageManager.shared.loadCategories() where category.name == categoryName {
                        
                        category.addToTask(taskToUpdate)
                    }
                } 
            } catch let error as NSError {
                print(error)
            }
        }
        else {
            let task = Task(context: managedContext)
            var taskId = UserDefaults.standard.integer(forKey: "lastTaskId")
            taskId += 1
            task.id = Int32(taskId)
            UserDefaults.standard.set(Int(taskId), forKey: "lastTaskId")
            task.title = title
            task.completionDate = date
            task.completed = false
            
            for category in PersistentStorageManager.shared.loadCategories() where category.name == categoryName {
                
                category.addToTask(task)
            }
        }
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func setCompleted(taskId: Int32) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        fetchRequest.predicate = NSPredicate(format: "id = %d", taskId)
        
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if !result.isEmpty {
                
                let taskToUpdate = result[0] as! Task
                taskToUpdate.completed = true
            }
        } catch let error as NSError {
            print(error)
        }
        
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    public func loadTasks(byID id: Int32? = nil, isCompleted: Bool = false ) -> [Task] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        if let param = id {
            fetchRequest.predicate = NSPredicate(format: "id = %d", param)
        }
        
        fetchRequest.predicate = NSPredicate(format: "completed = %@", NSNumber(booleanLiteral: isCompleted))
        
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as! [Task]
        } catch let error as NSError {
            print(error)
            return []
        }
    }
    
    
    public func loadCategories() -> [Category] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as! [Category]
        } catch let error as NSError {
            print(error)
            return []
        }
    }
    
    
    public func deleteTask(id: Int32) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let data = try managedContext.fetch(fetchRequest)
            
            let taskToDelete = data[0] as! NSManagedObject
            managedContext.delete(taskToDelete)
            do {
                try managedContext.save()
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    public func createInitialCategories() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let veryLowPriority = Category(context: managedContext)
        veryLowPriority.name = "Very Low Priority"
        veryLowPriority.colour = Constants.colourTaskVeryLowPriority
        
        let lowPriority = Category(context: managedContext)
        lowPriority.name = "Low Priority"
        lowPriority.colour = Constants.colourTaskLowPriority
        
        let mediumPriority = Category(context: managedContext)
        mediumPriority.name = "Medium Priority"
        mediumPriority.colour = Constants.colourTaskMediumPriority
        
        let highPriority = Category(context: managedContext)
        highPriority.name = "High Priotity"
        highPriority.colour = Constants.colourTaskHighPriority
        
        let veryHighPriority = Category(context: managedContext)
        veryHighPriority.name = "Very Hight Priority"
        veryHighPriority.colour = Constants.colourTaskVeryHighPriority
        
        let noPriority = Category(context: managedContext)
        noPriority.name = "No Priority"
        noPriority.colour = Constants.colourTaskNoPriority
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
}
