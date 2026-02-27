//
//  AIResponseView.swift
//  ToDoList
//
//  Created by Connor Hill on 9/12/24.
//

import SwiftUI

struct AIResponseView: View {
    @StateObject var viewModel = AIResponseViewViewModel()
    @Environment(\.dismiss) var dismiss
    @State var taskText: String = ""
    @State var subtaskText: String = ""
    let promptTopic: String
    let promptResults: [String]
    
    
    func hasNumberPrefix(_ string: String) -> Bool {
        let pattern = "^\\d+"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = regex.matches(in: string, options: [], range: range)
        
        return !matches.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("")
                    Text("")
                    Text("")
                    Text("")
                    Text("")
                    Text("Topic: \(promptTopic)")
                        .font(.custom("Montserrat-VariableFont_wght", size: 26))
                        .padding([.top, .trailing, .leading])
                    ForEach(promptResults, id: \.self) { result in
                        if hasNumberPrefix(result) {
                            HStack {
                                Text("Task: \(result)")
                                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                                    .padding([.top, .leading, .trailing])
                                Spacer()
                            }
                        }
                        else {
                            HStack {
                                Text("  Subtask: \(result)")
                                    .font(.custom("Montserrat-VariableFont_wght", size: 17))
                                    .opacity(0.7)
                                    .padding([.leading, .trailing])
                                Spacer()
                            }
                        }
                    }
                    .padding(2)
                    Spacer()
                    Button("Add this list to your collection!") {
                        // call the viewModel repeatedly to add all tasks and subtasks.
                        viewModel.addTasksAndSubtasks(promptResults, section: promptTopic)
                        viewModel.showingAIAddedAlert = true
                    }
                    .padding()
                    .font(.custom("Montserrat-VariableFont_wght", size: 20))
                    Text("(You may edit or delete tasks as needed.)")
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                        .opacity(0.6)
                        .padding()
                    Spacer()
                }
            }
        }
        .navigationTitle("New To Do List")
        .alert("New list has been added to your collection!", isPresented: $viewModel.showingAIAddedAlert) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                }
    }
}
