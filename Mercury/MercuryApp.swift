//
//  MercuryApp.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI

@main
struct MercuryApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            //TabView(selection: $selection) {
                NewsView()
                //.environment injects coreData into the app, adjust when adding ResultsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
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
