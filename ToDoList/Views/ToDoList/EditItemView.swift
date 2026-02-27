//
//  EditItemView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/25/24.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditItemViewViewModel()
    
    let item: ToDoListItem
    
    var body: some View {
        VStack {
            Text("Edit Task")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 75)
            
            Form {
                // Section
                TextField("Section", text: $viewModel.section)
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    .fontWeight(.semibold)
                
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Description
                TextField("Description", text: $viewModel.descripton)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
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
                viewModel.oldId = item.id
                viewModel.title = item.title
                viewModel.descripton = item.description
                viewModel.dueDate = Date(timeInterval: item.dueDate, since: .now)
                viewModel.isDone = item.isDone
                viewModel.section = item.section
            }
        }
    }
}

