import SwiftUI

struct Server: Identifiable {
    var id: Int
    let createdAt: Date
    let name: String
}

struct Channel: Identifiable, Equatable {
    var id: Int
    let createdAt: Date
    let name: String
}

struct MenuView: View {
    @State var selectedChannel: Channel?
    @State var showChannels = true
    
    var mockServers: [Server] = [
        Server(id:1, createdAt: .now, name: "Swift Community"),
        Server(id:2, createdAt: .now, name: "C++ Community"),
        Server(id:3, createdAt: .now, name: "Java Community"),
        Server(id:4, createdAt: .now, name: "Normal people"),
        Server(id:5, createdAt: .now, name: "WIC Study Group")
    ]
    
    var mockChannels: [Channel] = [
        Channel(id:1, createdAt: .now, name: "Swift Community"),
        Channel(id:2, createdAt: .now, name: "C++ Community"),
        Channel(id:3, createdAt: .now, name: "Java Community"),
        Channel(id:4, createdAt: .now, name: "Normal people"),
        Channel(id:5, createdAt: .now, name: "WIC Study Group")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            // Servers
            ScrollView {
                VStack {
                    ForEach(mockServers) { server in
                        Text(server.name.prefix(1))
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.discord)
                            )
                    }
                    Button {
                        // Action for button
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundStyle(.green)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .padding(-16)
                            )
                    }
                    .padding(.vertical, 16)
                }
            }
            .frame(width: 60)
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(8)
            .background(.ultraThickMaterial)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Swift Community")
                        .font(.title2)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .fontWeight(.heavy)
                }
                .padding(.bottom, 24)
                .padding(.trailing)
                Button {
                    withAnimation {
                        showChannels.toggle()
                    }
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: showChannels ?  "chevron.down": "chevron.right" )
                            .padding(.horizontal, 6)
                        Text("Text channels")
                            .textCase(.uppercase)
                            .font(.caption)
                            .bold()
                    }
                }
                .foregroundStyle(.gray)
                
                if showChannels{
                    ScrollView {
                        ForEach(mockChannels) { channel in
                            Button {
                                withAnimation {
                                    selectedChannel = channel
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "number")
                                    Text(channel.name)
                                        .font(.title3)
                                        .bold(selectedChannel == channel)
                                        .foregroundStyle(selectedChannel == channel ? .white: .gray)
                                }.foregroundStyle(.gray)
                            }
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(selectedChannel == channel ? Color(uiColor: .systemGray3): .clear)
                            }
                        }
                    }
                }
                else if let selectedChannel, !showChannels {
                    HStack {
                        Image(systemName: "number")
                        Text(selectedChannel.name)
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                    }.foregroundStyle(.gray)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(uiColor: .systemGray3))
                        }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .frame(width: 260)
            .padding(.top, 60)
            .padding(.leading)
            .background(Color.background)
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MenuView()
}

