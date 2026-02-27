//
//  SubTask.swift
//  ToDoList
//
//  Created by Connor Hill on 7/30/24.
//

import Foundation

struct SubTask: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var description: String
    var dueDate: Date
    var parentTaskId: String
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
