//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
            return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    func guestRegister() {
        var guestEmail = UUID().uuidString
        guestEmail.append("@guest.com")
        var guestPassword = UUID().uuidString
        guestPassword.append("@guest.com")
        var guestName = UUID().uuidString
        guestName.append("@guest.com")
        
        Auth.auth().createUser(withEmail: guestEmail, password: guestPassword) { [weak self] result, error in
            guard let userId = result?.user.uid else {
            return
            }
            self?.insertGuestRecord(guestId: userId, guestName: guestName, guestEmail: guestEmail)
        }
        self.email = guestEmail
        self.name = guestName
        self.password = guestPassword
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func insertGuestRecord(guestId: String, guestName: String, guestEmail: String) {
        let newUser = User(id: guestId,
                           name: guestName,
                           email: guestEmail,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(guestId)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
}
