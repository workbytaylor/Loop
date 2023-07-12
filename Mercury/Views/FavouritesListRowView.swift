//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI

struct FavouritesListRowView: View {
    @State var athlete: Athlete // remove athlete? update everywhere on edit // consider favourites only as id of each athlete - fetch each time?
    @State var index: Int
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button {
                
                switch athlete.isFavourite {
                case true?:
                    deleteFavourite()
                case false?:
                    addFavourite()
                case .none:
                    addFavourite()
                }
            } label: {
                Image(systemName: athlete.isFavourite == true ? "heart.fill" : "heart")
                    .font(.title3)
            }
            
            NavigationLink {
                AthleteView(athlete: athlete, index: index)
            } label: {
                Text("\(athlete.firstName) \(athlete.lastName)")
                    .foregroundColor(.primary)
            }
            
            Text(athlete.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private func addFavourite() {
        Task {
            // mark favourite
            athlete.isFavourite = true
            athletes.allAthletes[index].isFavourite = true
            
            // add to favourites table
            try await athletes.addFavourite(athlete: athlete, user_id: UUID(uuidString: session.user_id!)!)
        }
    }
    
    private func deleteFavourite() {
        Task {
            // mark not favourite
            athlete.isFavourite = false
            athletes.allAthletes[index].isFavourite = false
            
            // remove from favourites table in supabase
            try await athletes.removeFavourite(athlete_id: athlete.id)
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
            gender: "male",
            isPopular: false
        ),
                              index: 0)
        .padding()
    }
}


