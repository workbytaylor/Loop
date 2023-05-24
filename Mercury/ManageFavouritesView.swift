//
//  ManageFavouritesView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct ManageFavouritesView: View {
    @ObservedObject private var favourites = Favourites()
    
    var body: some View {
        List {
            Section {
                Text("Favourite")
            } header: {
                Text("Favourites")
            }
            
            Section {
                ForEach(favourites.athletes, id: \.id) { athlete in
                    Text("\(athlete.firstName) \(athlete.lastName)")
                }
            } header: {
                Text("Popular athletes")
            }
            .task {
                do {
                    try await favourites.getAthletes()
                } catch {
                    print(error)
                }
            }
        }
        .navigationTitle("Favourites")
    }
}

struct ManageFavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageFavouritesView()
    }
}
