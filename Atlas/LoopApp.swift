//
//  LoopApp.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI

@main
struct LoopApp: App {
    @StateObject var session: Session = Session()
    @StateObject var athletes: Athletes = Athletes()
    @StateObject var stories: Stories = Stories()
    @State private var selection: Int = 1
    @State private var showSignInSheet: Bool = false
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                HomeView(showSignInSheet: $showSignInSheet)
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
            .environmentObject(athletes)
            .environmentObject(stories)
            .preferredColorScheme(.light)
            .task {
                do {
                    try await stories.getAll()
                    try await athletes.getAthletes()
                    try await session.getSession()
                    try await athletes.getFavourites(user_id: session.user_id)
                    session.loginStatus = .loggedIn
                } catch {
                    showSignInSheet = true
                    print(error)
                }
            }
        }
    }
}
