//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
            let appear = UINavigationBarAppearance()
            let atters: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "MontserratRoman-Regular", size: 36)!
            ]

            appear.largeTitleTextAttributes = atters
            appear.titleTextAttributes = atters
            UINavigationBar.appearance().standardAppearance = appear
            UINavigationBar.appearance().compactAppearance = appear
            UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
