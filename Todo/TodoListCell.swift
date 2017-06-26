//
//  TodoListCell.swift
//  Todo
//
//  Created by Quang Vu on 6/23/17.
//  Copyright © 2017 Quang Vu. All rights reserved.
//

import Foundation
import UIKit

// Customize UITableViewCell class
class TodoListCell: UITableViewCell{
    
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var modificationDate: UILabel!
    @IBOutlet weak var briefDescription: UILabel!
    
    // Create a closure function that takes a tableview cell
    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBAction func completeTask(_ sender: Any) {
        // Execute our closure whenever user tap the Done button
        tapAction?(self)
    }
}
