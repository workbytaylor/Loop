//
//  FavouritesListView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesListView: View {
    @StateObject var items = Athletes()
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            /*
            if searchText != "" {
                Section {
                    NavigationLink {
                        // navigate to suggest an athlete
                    } label: {
                        Text("Can't find who you're looking for?")
                    }
                }
            }
             */
            
            Section {
                ForEach(items.athletes, id: \.id) { athlete in
                    FavouritesListRowView(athlete: athlete)
                }
            }
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .task {
            do {
                try await items.getAll()
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
