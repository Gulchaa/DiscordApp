//
//  UserSearchView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//

import SwiftUI

struct UserSearchView: View {
    var users = ["jason", "anne", "nohn", "james"]
    @State var userSearch = ""
    var body: some View {
        NavigationStack {
            List(users, id:\.self){ user in
                HStack{
                    Text(user.prefix(1))
                        .font(.largeTitle)
                        .frame(width:32)
                        .padding()
                        .foregroundStyle(.white)
                        .background{
                            Circle()
                                .fill(Color.discord)
                        }
                    Text(user)
                        .font(.title3)
                }
            }
            .frame(maxHeight: .infinity)
            .background(Color(.background))
            .scrollContentBackground(.hidden)
            .searchable(text: $userSearch)
            .navigationTitle("Users")
        }
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    UserSearchView()
}
