//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI

struct FavouritesListRowView: View {
    @Binding var athlete: Athlete
    @State private var isFavourite: Bool = false
    
    var body: some View {
        HStack {
            Text("\(athlete.firstName) \(athlete.lastName)")
            Text(athlete.country)
                .foregroundStyle(.secondary)
            Spacer()
            Button {
                isFavourite.toggle()
            } label: {
                switch isFavourite {
                case true:
                    Image(systemName: "heart.fill")
                case false:
                    Image(systemName: "heart")
                }
                
                
            }
        }
    }
}

/*
struct FavouritesListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesListRowView(athlete: Athlete()
    }
}
*/
