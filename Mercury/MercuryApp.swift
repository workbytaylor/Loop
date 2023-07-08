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
    @StateObject var athletes: Athletes = Athletes()
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
            .preferredColorScheme(.light)
            .task {
                do {
                    try await session.getSession()
                    session.loginStatus = .loggedIn
                    try await athletes.getAthletes(user_id: session.user_id)
                } catch {
                    showSignInSheet = true
                    print(error)
                }
            }
        }
    }
}
