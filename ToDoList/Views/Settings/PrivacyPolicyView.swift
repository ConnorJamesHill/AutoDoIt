//
//  PrivacyPolicyView.swift
//  ToDoList
//
//  Created by Connor Hill on 9/5/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Privacy Policy\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .font(.custom("Montserrat-VariableFont_wght", size: 26))
                    
                    Text("Last Updated: Thu Sep. 10, 2024\n")
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(0.80)
                        .font(.custom("Montserrat-VariableFont_wght", size: 14))
                    
                    Text("1. Introduction\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    This Privacy Policy explains how Auto Do It, owned and operated by Connor Hill in Pennsylvania, USA, collects, uses, and shares your personal information when you use our app.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("2. Information We Collect\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    Personal Information: We collect your email address, name, and password when you create an account.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    Text("•    Task Information: We collect the details of the tasks and subtasks you create within the app.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("3. How We Use Your Information\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    To Provide the Service: We use your information to operate and improve the Auto Do It app.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    Text("•    Communications: We may use your email address to send you important updates or information about the app.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("4. Data Storage and Security\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    Storage: Your data is stored securely on Firebase, a third-party service provider.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    Text("•    Security: We take reasonable measures to protect your data from unauthorized access. However, no system is completely secure, and we cannot guarantee the absolute security of your data.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("5. Sharing Your Information\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    Third-Party Services: We do not share your personal information with any third parties except as necessary to operate the app (e.g., Firebase for data storage).\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    Text("•    Legal Requirements: We may disclose your information if required by law or if we believe such action is necessary to comply with legal processes or protect the rights, property, or safety of Auto Do It or others.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("6. Your Rights\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    Access and Correction: You can access and update your account information directly through the app.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    Text("•    Deletion: You can delete your account at any time, and your personal information will be removed from our active systems.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("7. Changes to the Privacy Policy\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    We may update this Privacy Policy from time to time. We will notify you of any significant changes through the app. Your continued use of the app after such changes constitutes acceptance of the new Privacy Policy.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("8. Contact Information\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    If you have any questions or concerns about this Privacy Policy, please contact us at JamesConnorHill@gmail.com.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                }
                .padding()
            }
        }
        .navigationTitle("Privacy Policy")
    }
}
