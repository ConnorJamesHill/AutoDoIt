//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    /// Delete to do list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(item.id)
            .setData(itemCopy.asDictionary())
    }
    
    func toggleDoneItem(item: ToDoListItem) {
        
        var itemCopy = item
        itemCopy.setDoneItem(!item.doneViewItem)
        
        if itemCopy.isDone != itemCopy.doneViewItem {
            itemCopy.setDone(!itemCopy.isDone)
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(item.id)
            .setData(itemCopy.asDictionary())
    }
}
