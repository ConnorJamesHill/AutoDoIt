//
//  EditItemViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 7/25/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditItemViewViewModel: ObservableObject {
    @Published var int = 0
    
    @Published var oldId = ""
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var descripton = ""
    @Published var isDone = false
    @Published var doneViewItem = false
    @Published var section = ""
    
    @Published var showingSubViewAddScreen = false
    @Published var showingEditScreen = false
    
    @Published var subtasks: [SubTask] = []
    
    func save() {
        guard canSave else {
            return
        }
        
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            description: descripton,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: isDone,
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
        
        //delete old todo
        //        delete(id: oldId)
    }
    
    func delete(id: String) {
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func deleteSubtask(subtaskId: String) {
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("subtasks")
            .document(subtaskId)
            .delete()
    }
    
    func toggleIsDone(subtask: SubTask) {
        var subtaskCopy = subtask
        subtaskCopy.setDone(!subtask.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("subtasks")
            .document(subtask.id)
            .setData(subtaskCopy.asDictionary())
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
    
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in DispatchQueue.main.async {
            self?.currentUserId = user?.uid ?? ""
        }
        }
    }
}
