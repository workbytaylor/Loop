//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI
import CoreData

struct FavouritesListRowView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CachedAthlete.all()) private var favouriteAthletes
    
    @Binding var athlete: Athlete
    @State private var isFavourite: Bool = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(athlete.firstName) \(athlete.lastName)")
            Text(athlete.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Button {
                isFavourite.toggle()
                //toggle add/delete to/from coredata
            } label: {
                //try? moc.existingObject(with: athlete.id)
                
                
                
                /*
                switch isFavourite {
                case true:
                    Image(systemName: "heart.fill")
                case false:
                    Image(systemName: "heart")
                }
                */
                
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
