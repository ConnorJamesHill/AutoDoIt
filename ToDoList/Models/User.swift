//
//  User.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
