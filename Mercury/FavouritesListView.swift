//
//  FavouritesListView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesListView: View {
    // TODO: Likely need row level security and user management for this feature
    // If athletes are pulled from supabase, but favourites are stored in CoreData, how do you mix the two in the same list?
    // cache favourites somehow? and mix them each time?
    
    @ObservedObject var items = Athletes()
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            ForEach($items.athletes, id: \.id) { $athlete in
                FavouritesListRowView(athlete: $athlete)
            }
        }
        .searchable(text: $searchText, placement: .toolbar, prompt: "Search")
        .task {
            do {
                try await items.getAthletes()
            } catch {
                print(error)
            }
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        // sort by favourites at top, otherwise alphabetical
                    } label: {
                        Text("sort by favourites")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
        }
    }
}

struct ManageFavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FavouritesListView()
        }
    }
}
