//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by William Spanfelner on 01/11/2018.
//  Copyright © 2018 William Spanfelner. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>? //= [Category]()
// MARK: - "context" not required for Realm
//    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    /* The above line gives us the ability to CRUD entries in DB */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    
    //MARK: TableView DataSource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: - Nil Coalescing Operator - The statement below reads if categories is not nil return categories.count but if it is nil return 1.
        return categories?.count ?? 1
    }
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        /* the above line creates a reusable cell and adds it to the table at the indexPath */
        // MARK: - The statement below reads, "if categories[indexPath.row] is not nil then grab the "name" property. If categories[indexPath.row] is nil then set the text label equal to "No Categories Added Yet".
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    
    //MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add CATEGORY ToDoey ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //: With CoreData a context is not required to create a new Category
            let newCategory = Category()  //Category(context: self.context)
            //: The newCategory has a "name" property since it was defined.
            newCategory.name = textFeild.text!
            // MARK: - Since Results is auto-updating, it is unecessary to append things to it any longer as it will simply auto update.
//            self.categoryArray.append(newCategory)
            //: CoreData used ".saveCategories()".  Realm needs the newCategory we just created above.
            self.save(category: newCategory) //Categories()
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
            // MARK: -
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: Data manipulation methods
    //: The function is renamed and adjusted to take an argument since Realm is used now.
    func save(category: Category) {//saveCategories () {
        do {
            //:Here the context is referenced from when CoreData was used. What is required now that realm is employed is:
            try realm.write {//context.save()
                realm.add(category)
                print("*** category added ***")
            }
        } catch {
            print("Error saving category \( error.localizedDescription )")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {//(with request : NSFetchRequest<Category> = Category.fetchRequest() ) {
        categories = realm.objects(Category.self)
        
//
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \( error.localizedDescription )")
//        }
//
        tableView.reloadData()
    }

}
