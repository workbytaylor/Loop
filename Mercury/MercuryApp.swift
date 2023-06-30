//
//  MercuryApp.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI

@main
struct MercuryApp: App {
    @StateObject var user = User()
    //@StateObject var session: 
    @State private var selection: Int = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                HomeView()
                    //.toolbarBackground(Color.white, for: .tabBar)
                    .environmentObject(user)
                    .preferredColorScheme(.light)
                    .tabItem {
                        Text("News")
                        Image(systemName: "newspaper")
                    }
                    .tag(1)
                    .task {
                        /*
                        do {
                            try await AuthManager.shared.getCurrentSession()
                        } catch {
                            print(error)
                        }
                         */
                    }
                AltSettingsView()
                    .environmentObject(user)
                    .preferredColorScheme(.light)
                    .tabItem {
                        Text("Log in")
                        Image(systemName: "person.crop.circle")
                    }
                    .tag(2)
            }
            .task {
                
            }
        }
    }
}
