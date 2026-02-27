//
//  AIView.swift
//  ToDoList
//
//  Created by Connor Hill on 9/11/24.
//

import SwiftUI
import UIKit

struct AIView: View {
    @StateObject var viewModel = AIViewViewModel()
    
    @State var promptResults: [String] = []
    // manipulate prompt resonse
    
    func formatPrompt(prompty: String) {
        var tasksArray: [String] = []
        var trimmedTasksArray: [String] = []
        print("PROMPT:\n")
        print(prompty)
        // separate iniital prompt into an array of tasks with their subtasks
        let wordsArray = prompty.components(separatedBy: "###")
        // separate each array off tasks with their subtasks into one task or subtask string for each index as long as the index isn't empty
        for string in wordsArray {
            if !string.isEmpty {
                tasksArray.append(contentsOf: string.components(separatedBy: ">>>"))
            }
        }
        print("tasksArray:\n")
        print(tasksArray)
        // trim the new lines off of each string
        for string in tasksArray {
            trimmedTasksArray.append(string.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        // trim out open spaces at beginning and end of each string in the string array2
        
        print("trimmedTasksArray:\n")
        print(trimmedTasksArray)
        
        promptResults = trimmedTasksArray
    }
    
    var prompt: String {
        if !viewModel.promptRequiredTasks.isEmpty && !viewModel.promptRequiredSubtasks.isEmpty {
            let prompt: String = "I need you to make a todo list with a topic of \(viewModel.promptTopic). Only list of list of tasks with titles and descriptions to do for this topic. Each task should have at least one subtask. Use this exact same format for the to do list: 1.Task.>>>subtask.>>>subtask.###2.Task.>>>subtask.>>>subtask.###3.Task.>>>subtask.>>>subtask.###. You can include anywhere from one to three subtasks for each task. Consider including \(viewModel.promptRequiredTasks) for the tasks. Consider including \(viewModel.promptRequiredSubtasks) for the subtasks. Do not include new lines. Do not include any additional text. "
            return prompt
        } else if !viewModel.promptRequiredTasks.isEmpty && viewModel.promptRequiredSubtasks.isEmpty {
            let prompt: String = "I need you to make a todo list with a topic of \(viewModel.promptTopic). Only list of list of tasks with titles and descriptions to do for this topic. Each task should have at least one subtask. Use this exact same format for the to do list: 1.Task.>>>subtask.>>>subtask.###2.Task.>>>subtask.>>>subtask.###3.Task.>>>subtask.>>>subtask.###. You can include anywhere from one to three subtasks for each task. Consider including \(viewModel.promptRequiredTasks) for the tasks. Do not include new lines. Do not include any additional text. "
            return prompt
        } else if viewModel.promptRequiredTasks.isEmpty && !viewModel.promptRequiredSubtasks.isEmpty {
            let prompt: String = "I need you to make a todo list with a topic of \(viewModel.promptTopic). Only list of list of tasks with titles and descriptions to do for this topic. Each task should have at least one subtask. Use this exact same format for the to do list: 1.Task.>>>subtask.>>>subtask.###2.Task.>>>subtask.>>>subtask.###3.Task.>>>subtask.>>>subtask.###. You can include anywhere from one to three subtasks for each task. Consider including \(viewModel.promptRequiredSubtasks) for the subtasks. Do not include new lines. Do not include any additional text. "
            return prompt
        } else {
            let prompt: String = "I need you to make a todo list with a topic of \(viewModel.promptTopic). Only list of list of tasks with titles and descriptions to do for this topic. Each task should have at least one subtask. Use this exact same format for the to do list: 1.Task.>>>subtask.>>>subtask.###2.Task.>>>subtask.>>>subtask.###3.Task.>>>subtask.>>>subtask.###. You can include anywhere from one to three subtasks for each task. Do not include new lines. Do not include any additional text. "
            return prompt
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("What is the topic of your to do list?") {
                    ZStack(alignment: .leading) {
                        if viewModel.promptTopic.isEmpty {
                            VStack {
                                Text("Topic. (eg., Plan Vacation, Chore List, Wash Pets)...")
                                    .padding(.top, 10)
                                    .padding(.leading, 6)
                                    .opacity(0.6)
                                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                                Spacer()
                            }
                        }
                        VStack {
                            TextEditor(text: $viewModel.promptTopic)
                                .frame(minHeight: 60, maxHeight: 65)
                                .opacity(viewModel.promptTopic.isEmpty ? 0.25 : 1)
                                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                            Spacer()
                        }
                    }
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                Section("What tasks you would like in your to do list?") {
                    ZStack(alignment: .leading) {
                        if viewModel.promptRequiredTasks.isEmpty {
                            VStack {
                                Text("Required tasks: (eg., choose destination, book transportation, wash dishes, do laundry)")
                                    .padding(.top, 10)
                                    .padding(.leading, 6)
                                    .opacity(0.6)
                                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                                Spacer()
                            }
                        }
                        
                        VStack {
                            TextEditor(text: $viewModel.promptRequiredTasks)
                                .frame(minHeight: 60, maxHeight: 65)
                                .opacity(viewModel.promptRequiredTasks.isEmpty ? 0.25 : 1)
                                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                            Spacer()
                        }
                    }
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                Section("What subtasks you would like in your to do list?") {
                    ZStack(alignment: .leading) {
                        if viewModel.promptRequiredSubtasks.isEmpty {
                            VStack {
                                Text("Required subtasks: (eg., pack essentials, call dogsitter, fold clothes)")
                                    .padding(.top, 10)
                                    .padding(.leading, 6)
                                    .opacity(0.6)
                                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                                Spacer()
                            }
                        }
                        
                        VStack {
                            TextEditor(text: $viewModel.promptRequiredSubtasks)
                                .frame(minHeight: 60, maxHeight: 65)
                                .opacity(viewModel.promptRequiredSubtasks.isEmpty ? 0.25 : 1)
                                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                            Spacer()
                        }
                    }
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                VStack(alignment: .center) {
                    Button("Get Organized!") {
                        if viewModel.validate() {
                            Task {
                                do {
                                    try await viewModel.sendPromptToChatGPT(message: prompt)
                                    viewModel.showingAIResponseAlert = true
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .font(.custom("Montserrat-VariableFont_wght", size: 20))
            }
            .navigationTitle("Generate a New List!")
        }
        .sheet(isPresented: $viewModel.showingAIResponseView) {
            AIResponseView(promptTopic: viewModel.promptTopic, promptResults: promptResults)
        }
        .alert("To Do List Generated Successfully!", isPresented: $viewModel.showingAIResponseAlert) {
            Button("OK", role: .cancel) {
                formatPrompt(prompty: viewModel.promptResult)
                viewModel.showingAIResponseView = true
            }
        }
    }
}
