//
//  FavouritesListView.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesListView: View {
    @EnvironmentObject var athletes: Athletes
    @State private var isPresented: Bool = false
    //@State private var sort: Int = 0
    //@State private var filter: Int = 0
    //private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    var body: some View {
        //HStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(athletes.searchedAthletes, id: \.id) { athlete in
                        FavouritesListRowView(athlete: athlete) // consider changing to ??
                            .padding()
                    }
                }
            }
            .scrollIndicators(.never)
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
        .searchable(text: $athletes.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .overlay {
            // TODO: require users to be logged in to submit a suggestion
            // alert
            if athletes.searchedAthletes.isEmpty, !athletes.searchText.isEmpty {
                    VStack {
                        Text("Can't find \(athletes.searchText)?")
                            .font(.title3)
                            .bold()
                        Text("Let us know so we can add them to the list.")
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            Text("Suggest an athlete")
                                .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding()
                    }
            }
        }
        .sheet(isPresented: $isPresented) {
            SuggestionView()
                .presentationDragIndicator(.visible)
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        /*
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    // sort
                    Section {
                        Picker(selection: $sort, label: Text("Sorting options")) {
                            Text("Favourites").tag(0)
                            Text("Alphabetical").tag(1)
                        }
                        // name alphabetical
                    }
                    
                    // filter
                    Section {
                        // Filter all, favourites, popular
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
        }
         */
    }
}

struct ManageFavouritesView_Previews: PreviewProvider {
    static let athletes = Athletes()
    
    static var previews: some View {
        NavigationStack {
            FavouritesListView()
                .environmentObject(athletes)
        }
    }
}
