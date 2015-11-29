//
//  AddViewController.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    // Tasks container
    var taskContainer : TaskContainer?
    
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var urgentToggle: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.delegate = self
        saveButton.enabled = false
        NSLog("AddViewController#viewDidLoad")
    }
    
    // Save button pressed
    @IBAction func save(sender: AnyObject) {
        let description : String = descriptionField.text!
        let urgent : Bool = urgentToggle.on
        let task = Task(description: description, urgent: urgent)
        taskContainer!.addTask(task)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Cancel
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Delegate ----------------------------------------------------------------------------------
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        saveButton.enabled = descriptionField.text?.characters.count != 0
        return true
    }
}
