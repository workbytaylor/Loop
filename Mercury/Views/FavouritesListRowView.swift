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
    @State var athlete: Athlete
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(athlete.firstName) \(athlete.lastName)")
            Text(athlete.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Button {
                athlete.isFavourite?.toggle()
                print(athlete)
                
                
                if isAthleteFavourited(withID: athlete.id) == true {
                    // remove from favourites
                } else {
                    addToFavourites()
                }
                
            } label: {
                switch athlete.isFavourite {
                case true:
                    Image(systemName: "heart.fill")
                case false:
                    Image(systemName: "heart")
                default:
                    Image(systemName: "circle")
                }
                
            }
        }
        .task {
            // check if athlete is present here
            // assign appropriate value
            if isAthleteFavourited(withID: athlete.id) == true {
                
            } else {
                
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


extension FavouritesListRowView {
    
    // check if athlete is saved in CoreData
    private func isAthleteFavourited(withID id: UUID) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedAthlete.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let count = try moc.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error executing fetch request: \(error.localizedDescription)")
            return false
        }
    }
    
    // save new athlete to Coredata
    private func addToFavourites() {
        let newFavourite = CachedAthlete(context: moc)
        newFavourite.id = athlete.id
        newFavourite.firstName = athlete.firstName
        newFavourite.lastName = athlete.lastName
        newFavourite.country = athlete.country
        newFavourite.gender = athlete.gender
        try? moc.save()
    }
    
    
}
