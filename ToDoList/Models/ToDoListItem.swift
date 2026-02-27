//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import Foundation

struct ToDoListItem: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    var doneViewItem: Bool
    var section: String
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    mutating func setDoneItem(_ state: Bool) {
        doneViewItem = state
    }
}
