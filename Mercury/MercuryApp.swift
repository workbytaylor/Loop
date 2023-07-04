//
//  MercuryApp.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI

@main
struct MercuryApp: App {
    @StateObject var session: Session = Session()
    @State private var selection: Int = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Text("News")
                        Image(systemName: "newspaper")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Text(session.loginStatus == .loggedOut ? "Log in" : "Profile")
                        Image(systemName: "person.crop.circle")
                    }
                    .tag(2)
            }
            .environmentObject(session)
            .preferredColorScheme(.light)
            .task {
                do {
                    try await session.getSession()
                } catch {
                    print(error)
                }
            }
        }
    }
}
