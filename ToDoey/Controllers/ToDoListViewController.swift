//
//  ViewController.swift
//  ToDoey
//
//  Created by William Spanfelner on 24/10/2018.
//  Copyright © 2018 William Spanfelner. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

//    let itemArray = ["Bread", "Milk", "Cheese", "Eggs"]
/*
     As we cannot change the value of a constant, a new array must be declared as a variable.
 */
    
//    var itemArray = ["Bread", "Milk", "Cheese", "Eggs"]
  
    var toDoItems: Results<Item>? //[Item]()
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
// MARK: "context" no longer required for Realm
//    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    
//    let defaults = UserDefaults.standard /* we will make our own plist instead of using UserDefaults avoiding the                                         singleton*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first//?.appendingPathComponent("Items.plist")
        print("*", dataFilePath)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

//        let newItem = Item()
//        newItem.title = "Find Mike"
/*
     the following statement is used for debugging
 */
//        newItem.done = true

//        itemArray.append(newItem)
        
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
        
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
//        searchBar.delegate = self
//        loadItems()
    
    }
    
//MARK: - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAtIndexPath called")
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            /*
             Ternary operator ==> value = condition ? valueIfTrue : valueIfFalse
             */
            cell.accessoryType = item.done ? .checkmark : .none
            
            /*
             The statement above does the same thing as the "if else" block below and reads, "Set the cell's accessory type, depending upon whether item.done is true.  If true, then set the checkmark otherwise set item.done to .none
             */
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        return cell
    }

//TODO: - TableView Delegate Methods - This is the Update in CRUD
    //: This is where an item is selected in order to tick or un-tick the item.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
/*
         When a list item is tapped a checkmark appears at the right of the listing.  The checkmark remains whether we tap the item again or not - we want it to be unticked if tapped again
 */
/*
         context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
         
         The above two lines can be used to delete items, but user experience is not great.  The order of the statement matters a great deal, because the app will crash if the statements are reversed - as the array will be taken out of bounds.
 */
        /// The following statement could be used to update the title to completed instead of putting a tick mark as does the line that is uncommented.
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
// TODO: The code for deleting an item from a list follows.  It might be cool to implement this as a swipe action...
//                    realm.delete(item)
                    item.done.toggle()
                }
            }catch{
                print("Error saving done status, \(error)")
            }
            
        }
        tableView.reloadData()
//MARK: - commenting the statement below for convenience because it needs to be done slightly different for Realm
//        itemArray[indexPath.row].done.toggle() /* this is the same as the one line below */
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
/*
         The above statement is the same as the three if statements below
 
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }
 */
/*
         The conditional below takes care of turning the checkmark on or off given the correct tapping
 */
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
//MARK: - commenting the statement below for convenience because it needs to be done slightly different for Realm
//        saveItems()
        
//        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) /* This allows the selected row to return to its previous visual state instead of remaining grey after a row is tapped */
    }
    
//MARK: - Add New Items - This is the Create in CRUD
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController.init(title: "Add new ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
//  what will happen when the user clicks the Add Item button on our UIAlert
//            print(textFeild.text)
/*
    The info in this print statement is what we are after, and will need to be appended to the array
 */

// MARK: Following block commented out to use Realm
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()//(context: self.context)
                        newItem.title = textFeild.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()

//            let newItem = Item()
            
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory

//            self.itemArray.append(textFeild.text!)
//            self.itemArray.append(newItem)
      
//            self.saveItems()
            
//            let encoder = PropertyListEncoder()
//
//            do {
//                let data = try encoder.encode( self.itemArray )
//
//            try data.write(to: self.dataFilePath!)
//            } catch {
//                print( "Error encoding item array, \(error.localizedDescription)")
//            }
//
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
//
//            self.tableView.reloadData()
        }

//MARK: - Adding a cancel action to the alert [Add cancel to alert](https://stackoverflow.com/questions/24195310/how-to-add-an-action-to-a-uialertview-button-using-swift-ios)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (cancelAction) in
            NSLog("Cancel pressed")
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item."
            textFeild = alertTextField
//            print("Now!") /* This print is for testing only */
            
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction) // Added for cancel facility on the alert
        
        present(alert, animated: true, completion: nil)
        
    }
//MARK: - For Create, Update and Destroy data in CRUD
//    func saveItems() {
//
//        do {
//            try context.save()
//        }catch{
//            print( "Error saving context \( error.localizedDescription )" )
//        }
//
////        let encoder = PropertyListEncoder()
////
////        do {
////            let data = try encoder.encode( itemArray )
////            try data.write(to: dataFilePath!)
////        } catch {
////            print( "Error encoding item array, \(error.localizedDescription)")
////        }
//
//        self.tableView.reloadData()
//        }
    
//MARK: - For Reading database items in CRUD
    // MARK: Commented out for Realm
    func loadItems() { //(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil ) {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
 /* Item.fetchRequest() will be the default value unless one is supplied with the call */
//        let request : NSFetchRequest<Item> = Item.fetchRequest()  /* Line not required as we have the extension containing func searchBarSearchButtonClicked below */
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }


//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])

//        request.predicate = compoundPredicate
//
//        do {
//        itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \( error.localizedDescription )")
//        }
        /*       if let data = try? Data( contentsOf: dataFilePath! ) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
               print("Error decoding item array, \(error.localizedDescription)")
            }*/

        tableView.reloadData()

        }
    
}

// MARK: - Search Bar Methods
// MARK: Commented out for Realm
extension ToDoListViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //: loadItems() is necessary before filtering to reload the result list in the case that the search term needs to be altered.
        loadItems()
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
//        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
//: [Realm NSPredicate Cheatsheet](https://academy.realm.io/posts/nspredicate-cheatsheet/)
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
////        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
////        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
////        request.predicate = predicate
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
////        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
////        request.sortDescriptors = [sortDescriptor]
//
//        loadItems( with: request, predicate: predicate )

/*        do {
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \( error.localizedDescription )")
        } */

//        tableView.reloadData()

        print(searchBar.text!)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
//            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            searchBarSearchButtonClicked(searchBar)
        }
    }


}
