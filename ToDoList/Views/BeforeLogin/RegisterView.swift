//
//  RegisterView.swift
//  ToDoList
//
//  Created by Connor Hill on 6/27/24.
//

import SwiftUI
import UIKit

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
            VStack {
                // Header
                HeaderView(title: "Register.", subtitle: "Start organizing tasks!", angle: 15, background: .orange)
                Text("")
                Text("")
            }
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .font(.custom("Montserrat-VariableFont_wght", size: 16))
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .font(.custom("Montserrat-VariableFont_wght", size: 16))
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .font(.custom("Montserrat-VariableFont_wght", size: 16))
                TLButton(title: "Create Account", background: .green) {
                    viewModel.register()
                }
                .font(.custom("Montserrat-VariableFont_wght", size: 18))
                .fontWeight(.bold)
                Text("Or").frame(maxWidth: .infinity, alignment: .center).fontWeight(.thin).padding()
                    TLButton(title: "Sign in as a Guest", background: .cyan) {
                        viewModel.guestRegister()
                    }
                    .font(.custom("Montserrat-VariableFont_wght", size: 18))
                    .fontWeight(.bold)
            }
            .offset(y: -50)
            Spacer()
        }
}

#Preview {
    RegisterView()
}
