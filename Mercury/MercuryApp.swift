//
//  MercuryApp.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI

@main
struct MercuryApp: App {
    var body: some Scene {
        WindowGroup {
            //TabView(selection: $selection) {
                NewsView()
                .preferredColorScheme(.light)
                    .tabItem {
                        Text("News")
                        Image(systemName: "newspaper")
                    }
                    .tag(1)
                /*
                ResultsView()
                    .tabItem {
                        Text("Results")
                        Image(systemName: "list.bullet.rectangle")
                    }
                    .tag(2)
                */
            //}
        }
    }
}
