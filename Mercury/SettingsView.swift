//
//  SettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    FavouritesListView()
                } label: {
                    Label {
                        Text("Manage Favourites")
                    } icon: {
                        Image(systemName: "heart")
                    }
                }
                
                ShareLink("Share Mercury", item: URL(string: "https://www.tracksmith.com")!)
                
                Button {
                    //send email
                    if let url = URL(string: "mailto:workbytaylor@gmail.com") {
                      if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                      } else {
                        UIApplication.shared.openURL(url)
                      }
                    }
                } label: {
                    Label {
                        Text("Feedback")
                    } icon: {
                        Image(systemName: "message")
                    }
                }
            }
            
            Section(header: Text("About")) {
                Label {
                    Text("Made by Taylor in Ottawa")
                } icon: {
                    Image(systemName: "info.circle")
                }
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
