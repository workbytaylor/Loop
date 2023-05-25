//
//  ManageFavouritesView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct ManageFavouritesView: View {
    @StateObject var items = Athletes()
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            ForEach($items.athletes, id: \.id) { $athlete in
                FavouritesListRowView(athlete: $athlete)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .task {
            do {
                try await items.getAthletes()
            } catch {
                print(error)
            }
        }
        .navigationTitle("Manage Favourites")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        // sort by favourites
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
        ManageFavouritesView()
    }
}
