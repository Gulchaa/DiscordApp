//
//  EmailView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 03.11.24.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.authViewModel) var viewModel
    var body: some View {
        NavigationStack{
            @Bindable var viewModel = viewModel
            VStack {
                Text("Enter E-mail")
                    .font(.headline)
                    .bold()
                DiscordTextFieldView(header: "E-mail", placeholder: "", text: $viewModel.registerEmail)
                
                NavigationLink{
                    NameView()
                }label:{
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(.discord))
                }
                .disabled(viewModel.registerEmail.isEmpty)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.background))
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    NavigationStack{
        EmailView()
    }
}
