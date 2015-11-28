//
//  ViewController.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, TaskContainer {

    // Collection of tasks
    var taskCollection: [Task] = []
    
    // TableView containing the tasks
    @IBOutlet weak var taskView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create initial dummy tasks
        self.taskCollection.append(Task(description: "Response to my emails", urgent: false))
        self.taskCollection.append(Task(description: "Buy vin for tonight", urgent: true))
        self.taskCollection.append(Task(description: "Send cards", urgent: false))
        
        // Init the TableView
        self.taskView.delegate = self
        self.taskView.dataSource = self
        self.taskView.reloadData()
    }
    
    // open "Add task" view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? AddViewController {
            destinationVC.taskContainer = self
        }
    }
    
    // Functions for UITableViewDelegate and UITableViewDataSource -----------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskCollection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath) as UITableViewCell
        let task: Task = taskCollection[indexPath.row]
        cell.textLabel?.text = task.description
        cell.imageView?.hidden = !task.urgent
        return cell
    }
    
    // Functions for TaskContainer -------------------------------------------------------------------
    
    func addTask(task: Task) {
        taskCollection.append(task)
        self.taskView.reloadData()
    }
    
    // -----------------------------------------------------------------------------------------------
}

