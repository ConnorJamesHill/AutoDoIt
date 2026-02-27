//
//  ContentView.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    var body: some View {
        if (viewModel.isSignedIn && !viewModel.currentUserId.isEmpty) {
            accountView
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("To Do Lists", systemImage: "checklist")
                        .font(.custom("Montserrat-VariableFont_wght", size: 14))
                }
                .animation(.easeInOut, value: 1)
            DoneView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Completed Tasks", systemImage: "checkmark.rectangle.stack.fill")
                        .font(.custom("Montserrat-VariableFont_wght", size: 14))
                }
                .animation(.easeInOut, value: 1)
            AIView()
                .tabItem {
                    Label("Generate List", systemImage: "note.text.badge.plus")
                        .font(.custom("Montserrat-VariableFont_wght", size: 14))
                }
                .animation(.easeInOut, value: 1)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                        .font(.custom("Montserrat-VariableFont_wght", size: 14))
                }
                .animation(.easeInOut, value: 1)
        }
        .animation(.easeInOut, value: 1)
        .onAppear {
            
        }
    }
}
