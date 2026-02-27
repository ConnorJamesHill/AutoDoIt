//
//  LoginView.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import FirebaseAuth
import SwiftUI
import UIKit

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    @StateObject var contentViewModel = ContentViewViewModel()
    
    @State private var offsetValue: CGFloat = 0.0
    @State private var offsetNumber: CGFloat = 0.0
    let angle: Double = 68.0
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    HeaderView(title: "Auto Do It!", subtitle: "Get things done.", angle: -25, background: .pink)
                    VStack{
                        Form {
                            if !viewModel.errorMessage.isEmpty {
                                Text(viewModel.errorMessage)
                                    .foregroundColor(Color.red)
                            }
                            
                            TextField("Email Address", text: $viewModel.email)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .autocapitalization(.none)
                                .zIndex(3.0)
                                .font(.custom("Montserrat-VariableFont_wght", size: 16))
                            
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .zIndex(3.0)
                                .font(.custom("Montserrat-VariableFont_wght", size: 16))
                            
                            TLButton(title: "Log In", background: .blue) {
                                viewModel.login()
                                guard let uid = Auth.auth().currentUser?.uid else {
                                    return
                                }
                                contentViewModel.currentUserId = uid
                            }
                            .font(.custom("Montserrat-VariableFont_wght", size: 18))
                            .fontWeight(.bold)

                        }
                        VStack {
                            Text("New Around Here?")
                                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                            NavigationLink("Create An Account", destination: RegisterView())
                                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        }
                        .padding(.bottom, 30)
                        .onReceive(KeybordManager.shared.$keyboardFrame) { keyboardFrame in
                            if let keyboardFrame = keyboardFrame, keyboardFrame != .zero {
                                offsetNumber = 0.0
                            } else {
                                offsetNumber = 0.0
                            }
                        }
                    }
                }
            }
        }
    }
}

class KeybordManager: ObservableObject {
    static let shared = KeybordManager()

    @Published var keyboardFrame: CGRect? = nil

    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func willHide() {
        self.keyboardFrame = .zero
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        self.keyboardFrame = keyboardScreenEndFrame
    }
}

#Preview {
    LoginView()
}
