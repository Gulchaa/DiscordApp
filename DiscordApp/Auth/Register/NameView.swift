//
//  NameView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 05.11.24.
//

import SwiftUI

struct NameView: View {
    @Environment(\.authViewModel) var viewModel
    var body: some View {
        NavigationStack{
            @Bindable var viewModel = viewModel
            VStack {
                Text("What's your name?")
                    .font(.headline)
                    .bold()
                    .padding(.bottom, 24)
                DiscordTextFieldView(header: "Display Name", placeholder: "", text: $viewModel.registerDisplayName)
                
                NavigationLink{
                    UserNameView()
                        .environment(viewModel)
                }label:{
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(.discord))
                }
                .disabled(viewModel.registerDisplayName.isEmpty)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.background))
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    NameView()
}
