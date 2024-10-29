//
//  ChatView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//

import SwiftUI

struct Message: Identifiable{
    var id: Int?
    let createdAt: Date
    let username: String
    let imageURL: String
    let text: String
}

struct ChatView: View {
    @Binding var  showSideMenu: Bool
   
    
    var body: some View {
        VStack {
            HStack{
                Button{
                    withAnimation {showSideMenu = true}
                }
                label:{
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .foregroundStyle(.white)
                }
                Image(systemName: "number")
                
                Text("general")
                    .bold()
                    .font(.callout)
                
                Spacer()
                
                Image(systemName: "person.2.fill")
                
            } .padding()
                .padding(.top, 42)
                .background{
                    Color(uiColor: .systemGray6)
                }
            ChatRoomView()
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.dark)
        .background{
            Color.background
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ChatView(showSideMenu: .constant(false))
}
