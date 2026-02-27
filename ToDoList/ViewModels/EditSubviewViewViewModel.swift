//
//  EditSubviewViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 8/1/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditSubviewViewViewModel: ObservableObject {
    @Published var id = ""
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var description = ""
    @Published var isDone = false
    @Published var doneViewItem = false
    // Subtask info
    @Published var subtaskId = ""
    @Published var subtaskTitle = ""
    @Published var subtaskDescription = ""
    @Published var subtaskDueDate = Date()
    
    init() {}
    
    
    func save() {
        guard canSave else {
            return
        }
        
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let editedSubtask = SubTask(id: subtaskId,
                                    title: subtaskTitle,
                                    description: subtaskDescription,
                                    dueDate: subtaskDueDate,
                                    parentTaskId: id,
                                    isDone: isDone)
        
        //Save model to database as a subcollection of the current user (need to get id of curent user)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("subtasks")
            .document(subtaskId)
            .setData(editedSubtask.asDictionary())
    }
    
    func delete(id: String) {
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("subtasks")
            .document(id)
            .delete()
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
