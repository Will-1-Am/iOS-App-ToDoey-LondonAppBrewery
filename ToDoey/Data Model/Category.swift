//
//  Category.swift
//  ToDoey
//
//  Created by William Spanfelner on 26/03/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    /*:
     To reform the relationships as the CoreData database had, a List (Realm) object must be used. A List object is a container type like arrays and dictionarys. The kind of "List" needs to be specified and in this case the List will contain "Items".
     The statement below essentially re-establishes the relationship that existed previously.  Realm does not define the inverse relationship.  The inverse relationship has to be created manually.
     */
    let items = List<Item>()
}
