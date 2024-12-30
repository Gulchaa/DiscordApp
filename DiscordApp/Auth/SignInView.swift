//
//  SignInView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 03.11.24.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.authViewModel) var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack{
            Text("Welcome back!")
                .font(.title.bold())
            
            
            Text("We are excited to see you again!")
                .foregroundStyle(.secondary)
                .padding(.bottom)
            
            VStack(alignment: .leading){
                DiscordTextFieldView(header: "Account information", placeholder: "Email Adress", text: $viewModel.signInEmail)
                
                SecureField("Password", text: $viewModel.signInPassword)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button{
                viewModel.logIn()
            }label: {
                Text("Log In")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color(.discord))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.background))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SignInView()
}
