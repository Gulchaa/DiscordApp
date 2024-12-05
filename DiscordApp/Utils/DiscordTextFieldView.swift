//
//  DiscordTextFieldView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 03.11.24.
//

import SwiftUI

struct DiscordTextFieldView: View {
    var header:String
    var placeholder:String
    @Binding var text:String
    var body: some View {
        Text(header)
            .font(.footnote)
            .textCase(.uppercase)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.leading)
        
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.secondary.opacity(0.1))
    }
}

#Preview {
    DiscordTextFieldView(header: "Account information", placeholder: "Email", text: .constant(""))
}
