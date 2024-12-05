//
//  AuthView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 03.11.24.
//

import SwiftUI

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                Image("discord")
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width, height: 300)
                
                Spacer()
                
                Text("Welcome to Discord")
                    .font(.title)
                    .bold()
                
                Text("Join over 100 million people who already use Discrord!")
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                
                NavigationLink{
                    EmailView()
                        .environment(viewModel)
                } label: {
                    Text("Register")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(Color(.discord))
                .padding(.horizontal)
                
                NavigationLink{
                    SignInView()
                        .environment(viewModel)
                }label: {
                    Text("Log In")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(Color(.gray))
                .padding(.bottom)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.background)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AuthView()
}
