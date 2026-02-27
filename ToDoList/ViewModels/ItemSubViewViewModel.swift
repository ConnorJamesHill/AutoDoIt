//
//  ItemSubViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 7/30/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class ItemSubViewViewModel: ObservableObject {
    init() {}
    @Published var title = ""
    @Published var description = ""
    
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
}
