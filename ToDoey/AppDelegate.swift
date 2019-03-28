//
//  AppDelegate.swift
//  ToDoey
//
//  Created by William Spanfelner on 24/10/2018.
//  Copyright © 2018 William Spanfelner. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
/*:
       [Migrations in Realm](https://realm.io/docs/swift/latest#migrations)
 */
//        let config = Realm.Configuration (schemaVersion: 1,
//                                          migrationBlock: { migration, oldSchemaVersion in
//                if ( oldSchemaVersion < 1 ) {
//                    
//                }
//        })
//        Realm.Configuration.defaultConfiguration = config
        
//  print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as! String)
        //: To determine where the Realm file will be located:
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        //:Now that it has been shown that information can be saved to the database the block below can be commented out or deleted so that the same information is not added over and over again.
//        //: Now a new Realm data object can be created
//        let data = Data()
//        data.name = "William"
//        data.age = 7
        
        /*:
         After adding the Realm cocoa pods a new Realm must be added - a realm is like a persistent container.  Realm can throw, so it must be marked with a "try" and reside within a "do...catch" block.
         */
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        //: The data object needs to be added to our database using the C for Create in CRUD
        
        return true
    }
    

//    func applicationWillTerminate(_ application: UIApplication) {
//
//        self.saveContext()
//    }
    
    // MARK: - Core Data stack
    
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }


}

