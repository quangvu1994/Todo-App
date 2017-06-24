//
//  TodoListDetail.swift
//  Todo
//
//  Created by Quang Vu on 6/23/17.
//  Copyright © 2017 Quang Vu. All rights reserved.
//

import Foundation
import UIKit

class TodoListDetail: UIViewController{
    var task: Task?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var taskDetailField: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "Save" {
                let newTask = task ?? CoreDataHelper.newTask()
                newTask.title = titleField.text
                newTask.briefDescription = taskDetailField.text
                newTask.modificationDate = Date() as NSDate
                CoreDataHelper.saveTask()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currTask = task {
            titleField.text = currTask.title!
            taskDetailField.text = currTask.briefDescription!
        }else {
            titleField.text = ""
            taskDetailField.text = ""
        }
    }
    
    
}
