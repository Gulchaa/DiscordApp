//
//  AgeView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 11.11.24.
//

import SwiftUI

struct AgeView: View {
    @Environment(\.authViewModel) var viewModel
    var body: some View {
        NavigationStack{
            @Bindable var viewModel = viewModel
            VStack {
                Text("And, how old are you?")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 24)
                Text("Date of Birth")
                    .font(.footnote)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button{
                    
                }label:{
                    Text(viewModel.registerDOB.formatted())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.ultraThinMaterial)
                }
                
                Button{
                    viewModel.createAccount()
                } label:{
                    Text("Create an Account")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(.discord))
                }
                Spacer()
                
                DatePicker("", selection: $viewModel.registerDOB, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .padding()
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.background))
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AgeView()
}