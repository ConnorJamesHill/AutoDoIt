//
//  NewSubviewView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/31/24.
//

import Foundation
import SwiftUI

struct NewSubviewView: View {
    @StateObject var viewModel = NewSubviewViewViewModel()
    @StateObject var otherViewModel = EditItemViewViewModel()
    @Binding var newItemPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    let item: ToDoListItem
    
    var body: some View {
        VStack {
            Text("New Subtask")
                .font(.custom("Montserrat-VariableFont_wght", size: 32))
                .bold()
                .padding(.top, 75)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.subtaskTitle)
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    .fontWeight(.semibold)
                
                TextField("Description", text: $viewModel.subtaskDescription)
                    .font(.custom("Montserrat-VariableFont_wght", size: 15))
                    .opacity(0.75)
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        otherViewModel.subtasks.append(SubTask(id: viewModel.subtaskId, title: viewModel.subtaskTitle, description: viewModel.subtaskDescription, dueDate: viewModel.subtaskDueDate, parentTaskId: item.id, isDone: viewModel.isDone))
                        otherViewModel.int += 1
                        newItemPresented = false
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
                .font(.custom("Montserrat-VariableFont_wght", size: 15))
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in all fields and select due date that is today or newer"))
            }
            .onAppear() {
                viewModel.id = item.id
                viewModel.title = item.title
                viewModel.description = item.description
                viewModel.subtaskDueDate = Date(timeInterval: item.dueDate, since: .now)
            }
        }
    }
}
