//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI

struct FavouritesListRowView: View {
    @State var athlete: Athlete
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button {
                athlete.isFavourite?.toggle()
                
                
                //TODO: Add or remove from userFavourites table as required
                
                
                
                
            } label: {
                Image(systemName: athlete.isFavourite == true ? "heart.fill" : "heart")
                    .font(.title3)
            }
            
            NavigationLink {
                AthleteView(athlete: athlete)
            } label: {
                Text("\(athlete.firstName) \(athlete.lastName)")
                    .foregroundColor(.primary)
            }
            
            Text(athlete.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

struct FavouritesListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesListRowView(athlete: Athlete(
            id: UUID(),
            firstName: "Taylor",
            lastName: "Schaefer",
            country: "Canada",
            gender: "male"
        ))
        .padding()
    }
}

