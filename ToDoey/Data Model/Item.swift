//
//  Item.swift
//  ToDoey
//
//  Created by William Spanfelner on 26/03/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
/*:
     After adding the above property the following error is displayed at run-time and the app crashes.
     [The app crashes because the database does not match the database running in the simulator.](https://stackoverflow.com/questions/34598268/realm-migration-doesnt-work/53979285#53979285) and there are two options to fix the database: 1. Delete the app from the simulator and build and run the app again; 2. Migrate the database.
     Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: Error Domain=io.realm Code=10 "Migration is required due to the following errors:
     - Property 'Item.dateCreated' has been added." UserInfo={NSLocalizedDescription=Migration is required due to the following errors:
     - Property 'Item.dateCreated' has been added., Error Code=10}
 */
/*:
     Our inverse relationship (see the Category Data Model file) was called "parentCategory".  The Realm "LinkingObject" simply allows the inverse relationship to be defined.  The type must be specified as .self otherwise "Category" would refer to the class.
 */
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
