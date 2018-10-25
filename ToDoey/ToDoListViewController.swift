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
    
    var itemArray = ["Bread", "Milk", "Cheese", "Eggs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
    
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //TODO: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark /* When a list item is tapped a checkmark appears at the right of the listing.  The checkmark remains whether we tap the item again or not - we want it to be unticked if tapped again */
        /* The conditional below takes care of turning the checkmark on or off given the correct tapping */
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true) /* This allows the selected row to return to its previous visual state instead of remaining grey after a row is tapped */
    }

    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController.init(title: "Add new ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            //what will happen when the user click the Add Item button on our UIAlert
//            print(textFeild.text) /* The info in this print statement is what we are after, and will need to be appended to the array*/
            
            self.itemArray.append(textFeild.text!)
            
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

