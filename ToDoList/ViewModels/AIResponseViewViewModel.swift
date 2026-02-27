//
//  AIResponseViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 9/14/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class AIResponseViewViewModel: ObservableObject {
    @Published var showingAIAddedAlert: Bool = false
    
    // Task info
    @Published var id = ""
    @Published var dueDate = Date()
    @Published var doneViewItem = false
    // Subtask info
    @Published var tasks: [String] = []
    @Published var subTasks: [String] = []
    @Published var subtaskId: String = ""
    @Published var subtaskDescription: String = ""
    @Published var subtaskDueDate = Date()
    
    func hasNumberPrefix(_ string: String) -> Bool {
        let pattern = "^\\d+"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = regex.matches(in: string, options: [], range: range)
        
        return !matches.isEmpty
    }
    
    func addTasksAndSubtasks(_ tasksAndSubtasks: [String], section: String) {
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        for taskOrSubtask in tasksAndSubtasks {
            if hasNumberPrefix(taskOrSubtask) {
                // Create model
                let newId = UUID().uuidString
                self.id = newId
                let newItem = ToDoListItem(
                    id: id,
                    title: taskOrSubtask,
                    description: "",
                    dueDate: dueDate.timeIntervalSince1970,
                    createdDate: Date().timeIntervalSince1970,
                    isDone: false,
                    doneViewItem: doneViewItem,
                    section: section
                )
                
                //Save model to database as a subcollection of the current user (need to get id of curent user)
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(uId)
                    .collection("todos")
                    .document(newId)
                    .setData(newItem.asDictionary())
            }
            else {
                //Save model to database as a subcollection of the current user
                subtaskId = UUID().uuidString
                let newSubtask = SubTask(id: subtaskId,
                                         title: taskOrSubtask,
                                         description: subtaskDescription,
                                         dueDate: subtaskDueDate,
                                         parentTaskId: id,
                                         isDone: false)
                
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(uId)
                    .collection("subtasks")
                    .document(subtaskId)
                    .setData(newSubtask.asDictionary())
            }
        }
    }
}
