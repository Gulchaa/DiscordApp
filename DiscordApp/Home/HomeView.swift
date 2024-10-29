//
//  HomeView.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 29.10.24.
//

import SwiftUI

struct HomeView: View {
    @State var showSideMenu = false
    
    var body: some View {
        ZStack {
            //Menu View
            MenuView()
            //Chat View
            ChatView(showSideMenu: $showSideMenu)
                .offset(x: showSideMenu ? 340 : 0)
            
            Color.black
                .opacity(showSideMenu ? 0.7 : 0)
                .offset(x: showSideMenu ? 340 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showSideMenu = false
                    }
                }
        }.toolbar (showSideMenu ? .visible: .hidden, for: .tabBar)
    }
}

#Preview {
    HomeView()
}
