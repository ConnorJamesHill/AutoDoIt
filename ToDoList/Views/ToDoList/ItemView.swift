//
//  ItemView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/24/24.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct ItemView: View {
    @StateObject var viewModel = EditItemViewViewModel()
    @StateObject var settingsViewModel = SettingsViewViewModel()
    @Environment(\.dismiss) var dismiss
    
    var item: ToDoListItem
    let userId: String
    let db = Firestore.firestore()
    
    var imageName: String {
        if item.isDone {
            return "DoneImg"
        }
        else {
            return "NotDoneImg"
        }
    }
    
    var imageSubtitle: String {
        if item.isDone {
            return "Completed"
        }
        else {
            return "Not Completed Yet"
        }
    }
    
    func QueryFirebase() async {
        do {
            let querySnapshot = try await db.collection("users/\(userId)/subtasks").getDocuments()
            for document in querySnapshot.documents {
                let id = document.documentID
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let parentTaskId = data["parentTaskId"] as? String ?? ""
                let dueDate = data["dueDate"] as? Date ?? Date.now
                let isDone = data["isDone"] as? Bool ?? false
                if parentTaskId == item.id {
                    viewModel.subtasks.append(SubTask(id: id, title: title, description: description, dueDate: dueDate, parentTaskId: parentTaskId, isDone: isDone))
                }
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    func deleteSubtask(subtaskId: String) {
        viewModel.deleteSubtask(subtaskId: subtaskId)
        dismiss()
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .border(Color.primary, width: 3)
                    .frame(width: UIScreen.main.bounds.width/2)
                
                Text(imageSubtitle.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: CGFloat(-5 + (0 * viewModel.int)))
            }
            Text(item.title)
                .font(.custom("Montserrat-VariableFont_wght", size: 32))
                .foregroundStyle(.primary)
                .padding(2)
            
            Text(item.description)
                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                .foregroundStyle(.primary)
                .padding(2)
            
            Text("Due Date: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                .foregroundStyle(.secondary)
                .padding(2)
            Section("Subtasks") {
                List {
                    if viewModel.subtasks.isEmpty {
                        ContentUnavailableView {
                            Label("No Subtasks", systemImage: "nil")
                                .foregroundColor(.primary)
                                .bold()
                                .font(.custom("Montserrat-VariableFont_wght", size: 22))
                        } description: {
                            Text("You do not have any subtasks for this task.")
                                .font(.custom("Montserrat-VariableFont_wght", size: 16))
                        } actions: {
                            Button("Create subtask") {
                                withAnimation {
                                    viewModel.showingSubViewAddScreen = true
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(.primary)
                            .font(.custom("Montserrat-VariableFont_wght", size: 16))
                        }
                        .aspectRatio(contentMode: .fill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.primary, lineWidth: 5)
                        )
                        .background(.ultraThinMaterial)
                        Spacer()
                    } else {
                        ForEach(viewModel.subtasks) { subtask in
                            VStack {
                                ItemSubView(itemDueDate: item.dueDate, userId: userId, subtaskTitle: subtask.title, subtaskDescription: subtask.description, subtaskIsDone: subtask.isDone)
                                    .swipeActions {
                                        if subtask.isDone {
                                            Button("Not Done") {
                                                viewModel.toggleIsDone(subtask: subtask)
                                                if let index = viewModel.subtasks.firstIndex(where: {$0.id == subtask.id}) {
                                                    viewModel.subtasks[index].isDone.toggle()
                                                }
                                            }
                                            .tint(.yellow)
                                        }
                                        else {
                                            Button("Done") {
                                                viewModel.toggleIsDone(subtask: subtask)
                                                if let index = viewModel.subtasks.firstIndex(where: {$0.id == subtask.id}) {
                                                    viewModel.subtasks[index].isDone.toggle()
                                                }
                                            }
                                            .tint(.green)
                                        }
                                    }
                                    .swipeActions {
                                        Button("Delete") {
                                            withAnimation{viewModel.deleteSubtask(subtaskId: subtask.id)}
                                            if let index = viewModel.subtasks.firstIndex(where: {$0.id == subtask.id}) {
                                                viewModel.subtasks.remove(at: index)
                                            }
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .animation(.spring(), value: viewModel.subtasks)
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    viewModel.showingEditScreen = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add a Subtask", systemImage: "plus") {
                    viewModel.showingSubViewAddScreen = true
                }
            }
        }
        .sheet(isPresented: $viewModel.showingEditScreen) {
            EditItemView(item: item)
        }
        .sheet(isPresented: $viewModel.showingSubViewAddScreen) {
            NewSubviewView(newItemPresented: $viewModel.showingSubViewAddScreen, item: item)
        }
        .task{
            await QueryFirebase()
        }
    }
}
