//
//  ProfileView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 0){
                    Color.yellow
                        .frame(height: 200)
                    
                    ZStack(alignment: .topLeading){
                        Color.black
                            .frame(height: 140)
                        
                        VStack(alignment: .leading){
                            Image("jason")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .clipShape(Circle())
                                .background{
                                    Circle()
                                        .fill(.black)
                                        .padding(-8)
                                }
                            
                            Text("Jason")
                                .font(.title2)
                                .bold()
                                .padding(.leading, 20)
                        }
                        .offset(y: -50)
                    }
                    NavigationLink{
                        
                    } label:{
                        HStack{
                            Image(systemName: "person.crop.square.fill")
                            Text("Account")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(.gray)
                        .padding()
                    }
                    .background(Color(UIColor.systemGray4))
                    Divider()
                    
                    NavigationLink{
                        
                    } label:{
                        HStack{
                            Image(systemName: "pencil")
                            Text("Profile")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(.gray)
                        .padding()
                    }
                    .background(Color(UIColor.systemGray4))
                    
                    Divider()
                    
                    Button("Logout"){
                        Task{
                            do{
                                try await AuthService.shared.signOut()
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                    .foregroundStyle(.red)
                    .padding()
                }
            }
            .background(Color(.background))
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ProfileView()
}
