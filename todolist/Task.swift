//
//  Task.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import UIKit

class Task {
    
    // Description of the task
    var description: String? = nil
    
    // Is the task urgent?
    var urgent: Bool = false
    
    init(description:String, urgent: Bool) {
        self.description = description
        self.urgent = urgent
    }
}