//
//  FavouritesListRowView.swift
//  Loop
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
                if let index = athlete.index {
                    switch athletes.all[index].isFavourite {
                    case true?:
                        deleteFavourite()
                    case false?:
                        addFavourite()
                    case .none:
                        addFavourite()
                    }
                }
                
            } label: {
                if let index = athlete.index {
                    Image(systemName: athletes.all[index].isFavourite == true ? "heart.fill" : "heart")
                        .font(.title3)
                } else {
                    Image(systemName: "heart")
                        .font(.title3)
                }
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
    
    private func addFavourite() {
        Task {
            if let index = athlete.index {
                // mark favourite
                athletes.all[index].isFavourite = true
                
                // add to favourites table
                // TODO: crashes if user not logged in?
                try await athletes.addFavourite(athlete: index, user_id: UUID(uuidString: session.user_id!)!)
            }
        }
    }
    
    private func deleteFavourite() {
        Task {
            // mark not favourite
            if let index = athlete.index {
                athletes.all[index].isFavourite = false
            }
            
            // remove from favourites table in supabase
            try await athletes.removeFavourite(athlete_id: athlete.id)
        }
    }
}


struct FavouritesListRowView_Previews: PreviewProvider {
    static let athletes = Athletes()
    static let session = Session()
    
    static var previews: some View {
        FavouritesListRowView(athlete: Athlete(id: UUID(),
                                               firstName: "Taylor",
                                               lastName: "Schaefer",
                                               country: "Canada",
                                               gender: "male",
                                               isPopular: true))
        .padding()
        .environmentObject(athletes)
        .environmentObject(session)
    }
}


