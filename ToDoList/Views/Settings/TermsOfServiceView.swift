//
//  TermsOfServiceView.swift
//  ToDoList
//
//  Created by Connor Hill on 9/5/24.
//

import SwiftUI

struct TermsOfServiceView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Terms of Service\n")
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
                    
                    Text("Welcome to Auto Do It! These Terms of Service (“Terms”) govern your use of the Auto Do It app, owned and operated by Connor Hill, based in Pennsylvania, USA. By creating an account or otherwise using the Auto Do It app, you agree to be bound by these Terms.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("2. Use of the App\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("•    Eligibility: You must be at least 13 years old to use the Auto Do It app.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("•    Account Creation: To use the app, you must create an account by providing a valid email address, your name, and a secure password.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("•    User Responsibilities: You are responsible for maintaining the confidentiality of your account information, including your password. You agree not to use the app for any unlawful purposes.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("•    Prohibited Activities: You may not attempt to interfere with the app’s operation or access any data you are not authorized to access.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("3. Privacy\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("Our Privacy Policy governs the collection and use of your personal information. By using the Auto Do It app, you agree to the terms outlined in our Privacy Policy.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("4. Limitation of Liability\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("To the maximum extent permitted by law, Connor Hill and Auto Do It are not liable for any damages, including but not limited to, indirect, incidental, special, or consequential damages arising out of or related to your use of the app.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("5. Termination\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("We reserve the right to suspend or terminate your account at any time if we believe you have violated these Terms.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("6. Governing Law\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("These Terms are governed by the laws of the State of Pennsylvania, USA. Any disputes arising out of or relating to these Terms or your use of the app will be resolved in the courts located in Pennsylvania.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("7. Changes to the Terms\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("We may update these Terms from time to time. We will notify you of any significant changes through the app. Your continued use of the app after such changes constitutes acceptance of the new Terms.\n\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                    
                    Text("8. Contact Information\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 18))
                        .fontWeight(.semibold)
                    
                    Text("If you have any questions about these Terms, please contact us at ConnorJamesHill@gmail.com.\n")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Montserrat-VariableFont_wght", size: 16))
                }
                .padding()
            }
        }
        .navigationTitle("Terms of Service")
    }
}
