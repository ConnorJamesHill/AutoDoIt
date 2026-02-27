//
//  EditSubviewView.swift
//  ToDoList
//
//  Created by Connor Hill on 8/1/24.
//

import Foundation
import SwiftUI

struct EditSubviewView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditSubviewViewViewModel()
    
    let item: ToDoListItem
    
    let subtask: SubTask
    
    var body: some View {
        VStack {
            Text("Edit SubTask")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 75)
            Form {
                // Title
                TextField("Description", text: $viewModel.subtaskTitle)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("\(subtask.description)", text: $viewModel.subtaskDescription)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.subtaskDueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button
                TLButton(title: "Confirm Edit", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        viewModel.delete(id: item.id)
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in all fields and select due date that is today or newer"))
            }
            .onAppear() {
                viewModel.id = item.id
                viewModel.title = item.title
                viewModel.description = item.description
                viewModel.dueDate = Date(timeInterval: item.dueDate, since: .now)
                viewModel.isDone = item.isDone
                viewModel.subtaskId = subtask.id
                viewModel.subtaskTitle = subtask.title
                viewModel.subtaskDescription = subtask.description
                viewModel.subtaskDueDate = subtask.dueDate
            }
        }
    }
}
