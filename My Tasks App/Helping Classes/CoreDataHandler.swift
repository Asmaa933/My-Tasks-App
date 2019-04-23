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
    
    // ageb object mn core data
    //persistentContiner mn appdelegate
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
    //optional 3shan law feh tasks return array [tasks] , law m3rf4 ygbha w d5l f catch hyrag3 nil
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
    class func deleteObjectFromCoreData (task: Tasks) -> [Tasks]? {
        let context = CoreDataHandler.getCoreDataobject()
        context.delete(task)
        return CoreDataHandler.getDataFromCoreData()
    }
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


