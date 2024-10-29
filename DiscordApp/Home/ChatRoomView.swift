//
//  ChatRoomView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//

import SwiftUI

struct ChatRoomView: View {
    
    var mockMessages: [Message] = [
        .init(id: 1, createdAt: .now, username: "jas43on", imageURL: "jason", text: "Hello, world!"),
        .init(id: 2, createdAt: .distantPast, username: "peter120_lol", imageURL: "peter", text: "Hey there"),
        .init(id: 3, createdAt: .distantPast, username: "cat7890", imageURL: "cat", text: "What's up?")
    ]
    var body: some View {
        @State var message: String = ""
      
        VStack(alignment: .leading){
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Image(systemName: "number").imageScale(.large)
                            .padding()
                            .background{
                                Circle()
                                    .fill(Color(UIColor.systemGray3))
                            }
                            .padding(.bottom, 24)
                        Text("Welcome to general")
                            .font(.title2)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    LazyVStack{
                        ForEach(mockMessages){ message in
                            HStack(alignment: .top){
                                Image(message.imageURL)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 64, height: 48)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(message.username)
                                            .font(.caption)
                                        Text(message.createdAt.formatted(.dateTime))
                                            .font(.caption)
                                        Spacer()
                                    }
                                    Text(message.text)
                                        .font(.body)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            
            Divider()
            HStack{
                TextField("Message", text: $message)
                    .padding()
                    .background{
                        Capsule()
                            .fill((Color.primary.opacity(0.1)))
                    }
                Button{
                    
                }label:{
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                        .foregroundStyle(Color(uiColor: .systemGray6))
                        .background{
                            Circle()
                                .fill(.gray)
                        }
                }
                .frame(height: 70)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ChatRoomView()
}
