//
//  FavouritesListButtonView.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-06-18.
//

import SwiftUI

struct FavouritesListButtonView: View {
    var body: some View {
        NavigationLink {
            FavouritesListView()
        } label: {
            VStack {
                Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 60, height: 60)
                .background(Color.gray)
                .clipShape(Circle())
            Text("Favourites")
                .font(.caption)
                .foregroundColor(.primary)
            }
        }
    }
}

struct FavouritesListButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesListButtonView()
    }
}
