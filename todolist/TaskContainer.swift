//
//  TaskContainer.swift
//  todolist
//
//  Created by Loïc Monney on 28/11/15.
//  Copyright © 2015 Loïc Monney. All rights reserved.
//

import Foundation

protocol TaskContainer {
    
    func addTask(task: Task);
    
    func updateTask(index:Int, task:Task);
}