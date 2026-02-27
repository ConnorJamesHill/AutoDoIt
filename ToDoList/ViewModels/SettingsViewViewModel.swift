//
//  SettingsViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 7/26/24.
//

import Firebase
import FirebaseAuth
import Foundation
import SwiftUI

class SettingsViewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var showingPrivacyView: Bool = false
    @Published var showingTermsOfServiceView: Bool = false
    @Published var toDoItems: [String] = []
    @Published var subtaskItems: [String] = []
    
    @Published var deleteAccountalertIsShown: Bool = false
    @Published var deleteTodosAlertIsShown: Bool = false
    
 
    @StateObject var loginViewViewModel = LoginViewViewModel()
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    func login() {
        let email = loginViewViewModel.email
        let password = loginViewViewModel.password
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func deleteAccount() async throws {
        guard let currentUserHere = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        guard let lastSignInDate = currentUserHere.metadata.lastSignInDate else {
            return
        }
        let needsReauth = !lastSignInDate.isWithinPast(minutes: 5)
        
        do {
            if needsReauth {
                login()
                print("Login attempted")
            }
            try await currentUserHere.delete()
        }
        return
    }
    
    
    @StateObject var viewModel = LoginViewViewModel()
    
    init() {}
    
    @Published var user: User? = nil
    @Published var itemIsLarge: Bool = false
    
    func delete() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        print(toDoItems)
        for toDoItem in toDoItems {
            db.collection("users")
                .document(uid)
                .collection("todos")
                .document(toDoItem)
                .delete()
        }
        print(subtaskItems)
        for subtaskItem in subtaskItems {
            db.collection("users")
                .document(uid)
                .collection("subtasks")
                .document(subtaskItem)
                .delete()
        }
    }
}

extension Date {
    func isWithinPast(minutes: Int) -> Bool {
        let now = Date.now
        let timeAgo = Date.now.addingTimeInterval(-1 * TimeInterval(60 * minutes))
        let range = timeAgo...now
        return range.contains(self)
    }
}
