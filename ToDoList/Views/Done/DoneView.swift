//
//  DoneView.swift
//  ToDoList
//
//  Created by Connor Hill on 7/28/24.
//

import FirebaseFirestoreSwift
import SwiftUI

struct DoneView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var sections: [String] {
        var sections: [String] = []
        for item in sortedItems {
            if !sections.contains(item.section) {
                sections.append(item.section)
            }
        }
        return sections
    }
    
    var sortedItems: [ToDoListItem] {
        var sortedItems: [ToDoListItem] = []
        for item in items {
            if item.doneViewItem == true {
                sortedItems.append(item)
            }
        }
        return sortedItems
    }
    
    var sortedSections: [String] {
        var sortedSections: [String] = []
        for section in sections {
            for item in sortedItems {
                if section == item.section {
                    sortedSections.append(section)
                }
            }
        }
        return sortedSections
    }
    
    var fullySortedSections: [String] {
        var fullySortedSections: [String] = []
        var seen = Set<String>()
        for section in sortedSections {
            if !seen.contains(section) {
                seen.insert(section)
                fullySortedSections.append(section)
            }
        }
        return fullySortedSections
    }
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            // find this item
            let item = items[offset]
            
            // delete it from the context
            viewModel.delete(id: item.id)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if sortedItems.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                        Label("No Completed Tasks", systemImage: "nil")
                            .foregroundColor(.primary)
                            .bold()
                            .font(.custom("Montserrat-VariableFont_wght", size: 22))
                    } description: {
                        Text("You do not have any completed tasks yet.")
                            .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    } actions: {
                        Button("Create Task") {
                            withAnimation {
                                viewModel.showingNewItemView = true
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
                    ForEach(fullySortedSections, id: \.self) { section in
                        Group {
                            Section(section) {
                                ForEach(sortedItems) { item in
                                    Group {
                                        if item.section == section {
                                            NavigationLink(value: item) {
                                                ToDoListItemView(item: item)
                                                    .swipeActions {
                                                        if item.isDone {
                                                            Button("Not Done") {
                                                                viewModel.toggleIsDone(item: item)
                                                            }
                                                            .tint(.yellow)
                                                        }
                                                        else {
                                                            Button("Done") {
                                                                viewModel.toggleIsDone(item: item)
                                                            }
                                                            .tint(.green)
                                                        }
                                                    }
                                                    .swipeActions {
                                                        Button("Delete") {
                                                            withAnimation{viewModel.delete(id: item.id)}
                                                        }
                                                        .tint(.red)
                                                    }
                                                    .swipeActions(edge: .leading) {
                                                        Button("Add to Not-Completed", systemImage: "arrowshape.backward.circle") {
                                                            withAnimation {
                                                                viewModel.toggleDoneItem(item: item)
                                                            }
                                                        }
                                                        .tint(.orange)
                                                    }
                                            }
                                        }
                                    }
                                }
                                .onDelete(perform: withAnimation{deleteItems})
                            }
                        }
                    }
                }
            }
            .animation(.spring(), value: items)
            .listStyle(PlainListStyle())
            .navigationTitle("Completed Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .font(.custom("Montserrat-VariableFont_wght", size: 15))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .navigationDestination(for: ToDoListItem.self) { item in
                ItemView(item: item, userId: viewModel.currentUserId)
            }
        }
    }
}
