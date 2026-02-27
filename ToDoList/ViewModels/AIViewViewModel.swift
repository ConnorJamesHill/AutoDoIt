//
//  AIViewViewModel.swift
//  ToDoList
//
//  Created by Connor Hill on 9/11/24.
//

import Foundation
import SwiftUI

@MainActor class AIViewViewModel: ObservableObject {
    
    //    Test isbn: 9780765326355
    
enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
    @Published var promptResult: String = ""
    @Published var errorMessage: String = ""
    @Published var promptTopic: String = ""
    @Published var promptRequiredTasks: String = ""
    @Published var promptRequiredSubtasks: String = ""
    @Published var showingAIResponseView: Bool = false
    @Published var showingAIResponseAlert: Bool = false
    
    init () {}
    
    public func validate() -> Bool {
        guard !promptTopic.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard promptTopic.count < 100 else {
            errorMessage = "Please choose a shorter author name."
            return false
        }
        
        return true
    }
    
    private func generateURLRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        // METHOD
        urlRequest.httpMethod = httpMethod.rawValue
        
        // HEADER
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        
        // BODY
        let systemMessage = GPTMessage2(role: "system", content: "You are a helpful assistant.")
        let userMessage = GPTMessage2(role: "user", content: message)
        let payload = GPTChatPayload2(model: "gpt-3.5-turbo", messages: [systemMessage, userMessage], temperature: 0.0)
        let jsonData = try JSONEncoder().encode(payload)
        urlRequest.httpBody = jsonData
        return urlRequest
    }

    func sendPromptToChatGPT(message: String) async throws {
        let urlRequest = try generateURLRequest(httpMethod: .post, message: message)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let result = try JSONDecoder().decode(GPTResponse2.self, from: data)
        self.promptResult = result.choices[0].message.content
        print(result.choices[0].message.content)
    }
}

// Decoding Begins

struct GPTResponse2: Decodable {
    let choices: [GPTCompletion2]
}

struct GPTCompletion2: Decodable {
    let message: GPTResponseMessage2
}

struct GPTResponseMessage2: Decodable {
    let content: String
}

struct GPTFunctionCall2: Decodable {
    let name: String
    let arguments: String
}

// Decoding Ends

//Encoding begins

struct GPTChatPayload2: Encodable {
    let model: String
    let messages: [GPTMessage2]
    let temperature: Double
}

struct GPTMessage2: Encodable {
    let role: String
    let content: String
}

// Encoding Ends
