//
//  SwiftUIView.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    @StateObject var SettingsViewModel = SettingsViewViewModel()
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            if SettingsViewModel.itemIsLarge {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.custom("Montserrat-VariableFont_wght", size: 21))
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text(item.description)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .opacity(0.75)
                        .padding()
                    
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.custom("Montserrat-VariableFont_wght", size: 15))
                        .foregroundColor(Color(.secondaryLabel))
                        .padding()
                }
            }
            else {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text(item.description)
                        .font(.custom("Montserrat-VariableFont_wght", size: 15))
                        .opacity(0.75)
                    
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.custom("Montserrat-VariableFont_wght", size: 12))
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}
