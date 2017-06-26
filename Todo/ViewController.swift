//
//  ViewController.swift
//  Todo
//
//  Created by Quang Vu on 6/23/17.
//  Copyright © 2017 Quang Vu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var tableSections = ["Unfinished Task", "Completed Task"]
    
    var todoList = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var completeTaskList = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Retrieve the most up to date list of tasks
        (todoList, completeTaskList) = CoreDataHelper.retrieveTask()
    }
    
    // Set up the name of each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
    }
    
    // Set up number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    
    // Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [todoList, completeTaskList][section].count
    }
    
    // What we display per cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell View", for: indexPath) as! TodoListCell
        
        // Assign the correspond action for each cell's done button
        cell.tapAction = { [weak self] (cell) in
            self?.todoList[indexPath.row].taskComplete = true
            CoreDataHelper.saveTask()
            (self!.todoList, self!.completeTaskList) = CoreDataHelper.retrieveTask()

        }

        let task = [todoList, completeTaskList][indexPath.section][indexPath.row]
        
        cell.titleField.text = task.title!
        cell.modificationDate.text = task.modificationDate?.convertToString()
        cell.briefDescription.text = task.briefDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currTask = [todoList, completeTaskList][indexPath.section][indexPath.row]
            CoreDataHelper.delete(task: currTask)
            (todoList, completeTaskList) = CoreDataHelper.retrieveTask()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            // Transition to the detail view
            if identifier == "showDetail" {
                // Define our destination view
                let todoListDetail = segue.destination as! TodoListDetail
                // Find the indexPath of our selected row
                let currIndexPath = tableView.indexPathForSelectedRow!
                todoListDetail.task = [todoList, completeTaskList][currIndexPath.section][currIndexPath.row]
            }
        }
    }
    // Return segue to task list view controller which will deallocate the "from" view controller from the memory
    @IBAction func unwindToListView(_ segue: UIStoryboardSegue){
        // Retrieve the most up to date list of tasks
        (todoList, completeTaskList) = CoreDataHelper.retrieveTask()
    }
}


// Extend the NSDate class with a new function to convert Date to String
extension NSDate {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self as Date)
        return dateString
    }
}

