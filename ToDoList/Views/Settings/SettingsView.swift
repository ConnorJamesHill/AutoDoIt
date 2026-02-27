//
//  SettingsView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/26/24.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


struct SettingsView: View {
    
    
    @StateObject var profileViewModel = ProfileViewViewModel()
    @StateObject var settingsViewModel = SettingsViewViewModel()
    @StateObject var contentViewModel = ContentViewViewModel()
    @StateObject var appViewModel = AppViewModel()
    
    let db = Firestore.firestore()
    
    func QueryFirebaseForSubtasks() async {
        do {
            let querySnapshot = try await db.collection("users/\(profileViewModel.userId)/subtasks").getDocuments()
            for document in querySnapshot.documents {
                let id = document.documentID
                settingsViewModel.subtaskItems.append(id)
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    func QueryFirebaseForItems() async {
        do {
            let querySnapshot = try await db.collection("users/\(profileViewModel.userId)/todos").getDocuments()
            for document in querySnapshot.documents {
                let id = document.documentID
                settingsViewModel.toDoItems.append(id)
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("PROFILE")
                    .font(.custom("Montserrat-VariableFont_wght", size: 14)),
                        content: {
                    VStack {
                        profile()
                    }
                })
                Section(header: Text("PREFRENCES")
                    .font(.custom("Montserrat-VariableFont_wght", size: 14)),
                        content: {
                    Toggle("Dark Mode", systemImage: "moon", isOn: $isDarkMode)
                        .tint(.blue)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))

                    
                    HStack{
                        Image(systemName: "trash")
                        Text("Clear All Todo's")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        Spacer()
                        Button(action: {
                            settingsViewModel.deleteTodosAlertIsShown = true
                        }) {
                            Image(systemName: "exclamationmark")
                                .frame(minWidth: 0, maxWidth: 10, maxHeight: 5)
                                .padding()
                                .foregroundColor(.red)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        .cornerRadius(25)
                    }
                    
                    HStack{
                        Image(systemName: "trash")
                        Text("Delete Account")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        Spacer()
                        Button(action: {
                            settingsViewModel.deleteAccountalertIsShown = true
                        }) {
                            Image(systemName: "exclamationmark")
                                .frame(minWidth: 0, maxWidth: 10, maxHeight: 5)
                                .padding()
                                .onTapGesture {
                                    print("Edit trash buttonz tapped")
                                }
                                .foregroundColor(.red)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        .cornerRadius(25)
                    }
                })
                Section(header: Text("ABOUT")
                    .font(.custom("Montserrat-VariableFont_wght", size: 14)),
                        content: {
                    HStack{
                        Text("Privacy Policy")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        Button(action: {
                            settingsViewModel.showingPrivacyView = true
                        }) {}
                    }
                    HStack{
                        Text("Terms of Service")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        Button(action: {
                            settingsViewModel.showingTermsOfServiceView = true
                        }) {}
                    }
                    HStack{
                        Text("App Version: ")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        Text("1.0")
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    }
                })
            }
            .navigationTitle("Settings")
            .onAppear {
                profileViewModel.fetchUser2()
            }
            .task {
                await QueryFirebaseForItems()
                await QueryFirebaseForSubtasks()
            }
            .alert("Are you sure you want to delete your account?", isPresented: $settingsViewModel.deleteAccountalertIsShown) {
                Button("Delete", role: .destructive) {
                    Task {
                        do {
                            try await settingsViewModel.deleteAccount()
                        } catch {
                            print (error)
                        }
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
            .alert("Are you sure you want to delete your ToDo's?", isPresented: $settingsViewModel.deleteTodosAlertIsShown) {
                Button("Delete", role: .destructive) {
                    settingsViewModel.delete()
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $settingsViewModel.showingPrivacyView) {
                PrivacyPolicyView()
            }
            .sheet(isPresented: $settingsViewModel.showingTermsOfServiceView) {
                TermsOfServiceView()
            }
        }
    }
    
    @ViewBuilder
    func profile() -> some View {
        // Info: //Name//, Email, Member since
        VStack(alignment: .leading) {
            HStack {
                Text("Email: ")
                    .bold()
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                Text(profileViewModel.userEmail)
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
            }
            .padding()
            HStack {
                Text("Member Since: ")
                    .bold()
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                Text(profileViewModel.memberSince.formatted(date: .abbreviated, time: .shortened))
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
            }
            .padding()
        }
        .padding()
        
        // Sign out
        Button {
            profileViewModel.logOut()
            contentViewModel.currentUserId = ""
        } label: {
            Text("Log Out")
                .font(.custom("Montserrat-VariableFont_wght", size: 18))
        }
        .tint(.red)
        .padding()
        .buttonStyle(BorderlessButtonStyle())
        
        Spacer()
    }
}
