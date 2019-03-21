//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by William Spanfelner on 01/11/2018.
//  Copyright © 2018 William Spanfelner. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    /* The above line gives us the ability to CRUD entries in DB */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    
    //MARK: TableView DataSource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        /* the above line creates a reusable cell and adds it to the table at the indexPath */
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    //MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add CATEGORY ToDoey ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
         
            let newCategory = Category(context: self.context)
            newCategory.name = textFeild.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        //: Adding a cancel action to the alert
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (cancelAction) in
            NSLog("Cancel pressed")
        }
        //:
        alert.addAction(action)
        alert.addAction(cancelAction)  //Added this for cancel action
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Add a new category."
            textFeild = alertTextField

        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: Data manipulation methods
    func saveCategories () {
        do {
            try context.save()
        } catch {
            print("Error saving category \( error.localizedDescription )")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest() ) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \( error.localizedDescription )")
        }
        
        tableView.reloadData()
    }

}
