//
//  DiscordTabView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//
import SwiftUI

struct DiscordTabView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tag(0)
                .tabItem{
                    Image(systemName: "house.fill")
                }
            
            UserSearchView()
                .tag(1)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
            ProfileView()
                .tag(2)
                .tabItem{
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    DiscordTabView()
}
