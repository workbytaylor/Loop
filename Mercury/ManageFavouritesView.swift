//
//  ManageFavouritesView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct ManageFavouritesView: View {
    @StateObject private var items = Favourites()
    @State private var userFavourites: [Athlete] = []
    
    var body: some View {
        List {
            ForEach(items.athletes, id: \.id) { athlete in
                HStack {
                    Text("\(athlete.firstName) \(athlete.lastName)")
                    Text(athlete.country)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button {
                        // add to favourites
                    } label: {
                        Image(systemName: "heart")
                    }
                }
            }
        }
        .task {
            do {
                try await items.getFavourites()
            } catch {
                print(error)
            }
        }
        .navigationTitle("Favourites")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // open sheet to add more favourites
                } label: {
                    Label {
                        Text("Add to favourites")
                    } icon: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ManageFavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageFavouritesView()
    }
}
