//
//  FavouritesListView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesListView: View {
    @StateObject private var athletes = Athletes()
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
                ForEach(athletes.all, id: \.id) { athlete in
                    FavouritesListRowView(athlete: athlete)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .task {
            do {
                try await athletes.getAll()
                //try await athletes.getFavourites()    // why is this here?
            } catch {
                print(error)
            }
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    //TODO: Sort by
                        //name, alphabetical
                        //country, alphabetical
                        //popularity
                    //TODO: Filter by
                        //all
                        //favourites only
                    
                    
                    Button {
                        // sort by favourites at top, otherwise alphabetical
                    } label: {
                        Text("sort & filter")
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
