//
//  ItemSubView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/30/24.
//

import Foundation
import SwiftUI

struct ItemSubView: View {
    @StateObject var viewModel = ItemSubViewViewModel()
    @StateObject var SettingsViewModel = SettingsViewViewModel()
    @Environment(\.dismiss) var dismiss
    
    let itemDueDate: Double
    var userId: String
    let subtaskTitle: String
    let subtaskDescription: String
    let subtaskIsDone: Bool
    
    @State private var showingSubViewEditScreen = false
    @State private var showingSubViewAddScreen = false
    
    var body: some View {
        HStack {
            if SettingsViewModel.itemIsLarge {
                VStack(alignment: .leading) {
                    Text(subtaskTitle)
                        .font(.custom("Montserrat-VariableFont_wght", size: 21))
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text(subtaskDescription)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .opacity(0.75)
                        .padding()
                }
            }
            else {
                VStack(alignment: .leading) {
                    Text(subtaskTitle)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text(subtaskDescription)
                        .font(.custom("Montserrat-VariableFont_wght", size: 15))
                        .opacity(0.75)
                }
                Spacer()
                Button {
                } label: {
                    Image(systemName: subtaskIsDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
}
