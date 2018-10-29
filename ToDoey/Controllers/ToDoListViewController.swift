//
//  ViewController.swift
//  ToDoey
//
//  Created by William Spanfelner on 24/10/2018.
//  Copyright © 2018 William Spanfelner. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

//    let itemArray = ["Bread", "Milk", "Cheese", "Eggs"]  /* As we cannot change the value of a constant, a new array must be declared as a variable.*/
    
//    var itemArray = ["Bread", "Milk", "Cheese", "Eggs"]
  
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
//        newItem.done = true  /* used for debugging */
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAtIndexPath called")
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none  /* This line does the same thing as the if block below
                                                                and reads, "Set the cell's accessory type, depending upon whether item.done is true.  If true, then set the checkmark otherwise set item.done to .none */
        
        if item.done == true {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }

    //TODO: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark /* When a list item is tapped a checkmark appears at the right of the listing.  The checkmark remains whether we tap the item again or not - we want it to be unticked if tapped again */
        
        itemArray[indexPath.row].done.toggle() /* this is the same as the one line below */
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done   /* this is the same as the three if block below */
//
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
        /* The conditional below takes care of turning the checkmark on or off given the correct tapping */
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) /* This allows the selected row to return to its previous visual state instead of remaining grey after a row is tapped */
    }

    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController.init(title: "Add new ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            //what will happen when the user click the Add Item button on our UIAlert
//            print(textFeild.text) /* The info in this print statement is what we are after, and will need to be appended to the array*/
            
            let newItem = Item()
            newItem.title = textFeild.text!
            
//            self.itemArray.append(textFeild.text!)
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item."
            textFeild = alertTextField
//            print("Now!") /* This print is for testing only */
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
