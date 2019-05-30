//
//  CoreDataHandler.swift
//  My Tasks App
//
//  Created by AsMaa on 4/18/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    
    // need  object from Core Data
    //persistentContiner from appDelegate
    class  func getCoreDataobject() -> NSManagedObjectContext {
        // object mn AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // save into core Data
    class func saveIntoCoreData(taskItem: Tasks){
        let context = CoreDataHandler.getCoreDataobject()
        do{
            try context.save()
            print("Saved")
        } catch (let error){
            print(error.localizedDescription)
        }
    }
    // get data from core data
    //optional in case there are tasks return array [tasks] , no tasks and enter catch return nil
    class func getDataFromCoreData() -> [Tasks]? {
        let context = CoreDataHandler.getCoreDataobject()
        var tasks : [Tasks]?
        do{
            // fetch return array[any]
            tasks = try context.fetch(Tasks.fetchRequest())
        } catch (let error){
            print(error.localizedDescription)
        }
        
        return tasks
        
    }
    // delete item from Core Data
    class func deleteObjectFromCoreData (task: Tasks) -> [Tasks]? {
        let context = CoreDataHandler.getCoreDataobject()
        context.delete(task)
// save here to save after remove items as if you don't save after relanuch app again the items still in Core Data
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
        return CoreDataHandler.getDataFromCoreData()
    }
    // get an item from Core Data
    class func getspecificItemFromCoreData(itemName: String) -> [Tasks]{
        var tasks = [Tasks]()
        let context = CoreDataHandler.getCoreDataobject()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Tasks.entity().name ?? "")
        request.predicate = NSPredicate(format: "taskName contains[cs] %@", itemName)
        do{
            tasks =  try  context.fetch(request) as? [Tasks] ?? []
        }catch(let error){
            print(error.localizedDescription)
        }
        return tasks
        
    }
}


