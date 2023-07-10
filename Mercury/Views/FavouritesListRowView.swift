//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI

struct FavouritesListRowView: View {
    @State var athlete: Athlete
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button {
                
                switch athlete.isFavourite {
                case true?:
                    Task {
                        // mark not favourite
                        athlete.isFavourite = false
                        // remove from favourites in swift
                        athletes.favouriteAthletes.removeAll { $0.id == athlete.id }
                        // remove from favourites table in supabase
                        try await athletes.removeFavourite(athlete_id: athlete.id)
                    }
                case false?:
                    Task {
                        // mark favourite
                        athlete.isFavourite = true
                        athletes.favouriteAthletes.append(athlete)
                        // add to favourites table
                        try await athletes.addFavourite(athlete: athlete, user_id: UUID(uuidString: session.user_id!)!)
                    }
                    
                    
                case .none:
                    Task {
                        // mark favourite
                        athlete.isFavourite = true
                        athletes.favouriteAthletes.append(athlete)
                        // add to favourites table
                        try await athletes.addFavourite(athlete: athlete, user_id: UUID(uuidString: session.user_id!)!)
                    }
                }
                
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

