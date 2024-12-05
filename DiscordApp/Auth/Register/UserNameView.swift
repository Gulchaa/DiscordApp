//
//  UserNameView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 05.11.24.
//

import SwiftUI

struct UserNameView: View {
    @Environment(\.authViewModel) var viewModel
    var body: some View {
        NavigationStack{
            @Bindable var viewModel = viewModel
            VStack {
                Text("Next, create an account")
                    .font(.headline)
                    .bold()
                    .padding(.bottom, 24)
                DiscordTextFieldView(header: "Username", placeholder: "", text: $viewModel.registerUsername)
                Text("Password")
                    .font(.footnote)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading)
                
                SecureField("", text: $viewModel.registerPassword)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                NavigationLink{
                    AgeView()
                        .environment(viewModel)
                }label:{
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(.discord))
                }
                .disabled(viewModel.registerUsername.isEmpty)
                .disabled(viewModel.registerPassword.isEmpty)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.background))
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    UserNameView()
}
