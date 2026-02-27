//
//  NewItemView.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("New Task")
                .font(.custom("Montserrat-VariableFont_wght", size: 32))
                .bold()
                .padding(.top, 75)
            
            Form {
                // Section
                TextField("Section", text: $viewModel.section)
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    .fontWeight(.semibold)
                // Title
                TextField("Title", text: $viewModel.title)
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    .fontWeight(.semibold)
                // Description
                TextField("Description", text: $viewModel.description)
                    .font(.custom("Montserrat-VariableFont_wght", size: 15))
                    .opacity(0.75)
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .font(.custom("Montserrat-VariableFont_wght", size: 12))
                
                // Button
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
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
        }
    }
}
