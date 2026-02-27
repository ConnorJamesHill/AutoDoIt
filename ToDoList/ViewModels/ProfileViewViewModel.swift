//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var userName: String = ""
    @Published var memberSince: Date = Date()
    @Published var userId: String = ""
    
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser2() {
        guard let userId = Auth.auth().currentUser else {
            return
        }
        self.userId = userId.uid
        self.userEmail = userId.email ?? ""
        self.userName = userId.displayName ?? ""
        self.memberSince = userId.metadata.creationDate ?? Date()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        print(userId)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                    self?.user = User(id: data["id"] as? String ?? "",
                                      name: data["name"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      joined: data["joined"] as? TimeInterval ?? 0)
            }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    
}
