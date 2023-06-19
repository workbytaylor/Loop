//
//  FavouritesListView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesListView: View {
    @StateObject private var vm = Athletes()
    //private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    var body: some View {
        
        //HStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.searchedAthletes, id: \.id) { athlete in
                        FavouritesListRowView(athlete: athlete)
                            .padding()
                    }
                }
            }
        /*
            VStack {
                ForEach(letters, id: \.self) { letter in
                    Text(String(letter))
                        .font(.caption)
                }
            }
            .padding(.trailing)
        */
         //}
        .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .overlay {
            if vm.searchedAthletes.isEmpty, !vm.searchText.isEmpty {
                NavigationLink {
                    // TODO: Suggestion form connected to supabase
                    // TODO: Change to button below text
                    Text("Suggestions")
                } label: {
                    VStack {
                        Text("Can't find \"\(vm.searchText)\"?")
                            .font(.headline)
                        Text("Help us add them to our database")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .task {
            do {
                try await vm.fetchData()
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
