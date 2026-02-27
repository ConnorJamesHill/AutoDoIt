//
//  Secrets.swift
//  ToDoList
//
//  Created by Connor Hill on 9/11/24.
//

import Foundation

enum Secrets {
    /// Set OPENAI_API_KEY in your environment or Xcode scheme for API access
    static var apiKey: String {
        ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
    }
}
