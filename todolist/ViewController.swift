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
    var modify:Bool = false
    var taskCollection: [Task] = []
    
    
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    @IBAction func enableModify(sender: AnyObject) {
        modify = !modify
        let btn = sender as! UIBarButtonItem
        if(modify)
        {
            btn.title = "Done"
        }
        else
        {
            btn.title = "Edit"
        }
        saveTasks()
        taskView.reloadData()
        
    }
    // TableView containing the tasks
    @IBOutlet weak var taskView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedTask = loadTasks() {
            taskCollection += savedTask
        } else {
            // Create initial dummy tasks
            self.taskCollection.append(Task(taskText: "Response to my emails", urgent: false))
            self.taskCollection.append(Task(taskText: "Buy gnole for tonight", urgent: true))
            self.taskCollection.append(Task(taskText: "Send cards", urgent: false))
        }
        
        
        // Init the TableView
        self.taskView.delegate = self
        self.taskView.dataSource = self
        self.taskView.reloadData()
        
        NSLog("ViewController#viewDidLoad")
    }
    
    // open "Add task" view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? AddViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "ModifySegue":
                        let indexPath = self.taskView.indexPathForSelectedRow
                        destinationVC.taskToModifiy = taskCollection[indexPath!.row]
                        destinationVC.isUpdate = true;
                        destinationVC.indexUpdate = indexPath!.row
                        destinationVC.taskContainer = self
                    default:
                        destinationVC.taskContainer = self
                }
            }
            
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
        cell.textLabel?.text = task.taskText
        cell.imageView?.hidden = !task.urgent
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return modify
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            taskCollection.removeAtIndex(indexPath.row)
            taskView.reloadData()
        }
    }
    
    //func tableView
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("ViewController#ClickOnItem")
        self.performSegueWithIdentifier("ModifySegue", sender: indexPath);
    }*/
    
    
    
    // Functions for TaskContainer -------------------------------------------------------------------
    
    func addTask(task: Task) {
        taskCollection.append(task)
        saveTasks()
        self.taskView.reloadData()
    }
    
    func updateTask(index:Int, task: Task){
        taskCollection[index] = task
        saveTasks()
        self.taskView.reloadData()
    }
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(taskCollection, toFile: Task.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        }
    }
    
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    }
    
    // -----------------------------------------------------------------------------------------------
}

