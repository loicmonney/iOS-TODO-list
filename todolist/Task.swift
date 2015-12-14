//
//  Task.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import UIKit

class Task : NSObject, NSCoding {
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    // Description of the task
    var taskText: String? = nil
    
    // Is the task urgent?
    var urgent: Bool = false
    
    init(taskText:String, urgent: Bool) {
        self.taskText = taskText
        self.urgent = urgent
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let taskText = decoder.decodeObjectForKey(TaskKey.textKey) as? String
            else { return nil }
        
        self.init(taskText:taskText, urgent: decoder.decodeBoolForKey(TaskKey.urgentKey))
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.taskText, forKey: TaskKey.textKey)
        coder.encodeBool(self.urgent, forKey: TaskKey.urgentKey)
    }
    
    struct TaskKey {
        static let textKey = "taskText"
        static let urgentKey = "urgent"
    }
}