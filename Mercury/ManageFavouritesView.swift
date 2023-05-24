//
//  ManageFavouritesView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct ManageFavouritesView: View {
    var body: some View {
        List {
            Section {
                Text("Favourite")
            } header: {
                Text("Favourites")
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
