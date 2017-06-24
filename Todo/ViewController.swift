//
//  ViewController.swift
//  Todo
//
//  Created by Quang Vu on 6/23/17.
//  Copyright © 2017 Quang Vu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    var todoList = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList = CoreDataHelper.retrieveTask()
    }
    
    // Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // What we display per cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell View", for: indexPath) as! TodoListCell
        cell.titleField.text = todoList[indexPath.row].title!
        cell.modificationDate.text = todoList[indexPath.row].modificationDate?.convertToString()
        cell.briefDescription.text = todoList[indexPath.row].briefDescription
        
        return cell
    }
    @IBAction func finishTask(_ sender: Any) {
        // Remove the task from our list, but we not from our Core Data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            // Transition to the detail view
            if identifier == "showDetail" {
                // Define our destination view
                let todoListDetail = segue.destination as! TodoListDetail
                // Find the indexPath of our selected cell
                let currIndexPath = tableView.indexPathForSelectedRow!
                todoListDetail.task = todoList[currIndexPath.row]
            }
        }
    }
    // Return segue to task list view controller which will deallocate the "from" view controller from the memory
    @IBAction func unwindToListView(_ segue: UIStoryboardSegue){
        todoList = CoreDataHelper.retrieveTask()
    }
}

extension NSDate {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self as Date)
        return dateString
    }
}

