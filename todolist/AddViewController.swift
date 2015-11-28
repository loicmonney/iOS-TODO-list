//
//  AddViewController.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var taskContainer : TaskContainer?
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var urgentToggle: UISwitch!
    
    @IBAction func save(sender: AnyObject) {
        let description : String = descriptionField.text!
        let urgent : Bool = urgentToggle.on
        let task = Task(description: description, urgent: urgent)
        taskContainer!.addTask(task)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
