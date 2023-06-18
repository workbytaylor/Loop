//
//  FavouritesListRowView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-25.
//

import SwiftUI
import CoreData

struct FavouritesListRowView: View {
    @State var athlete: Athlete
    @State private var isFavourite: Bool = false
    @StateObject private var items = Athletes()
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button {
                isFavourite.toggle()
                //TODO: Add or remove from userFavourites table as required
                
                
                
                
                
            } label: {
                Image(systemName: isFavourite == true ? "heart.fill" : "heart")
                    .font(.headline)
            }
            
            Text("\(athlete.firstName) \(athlete.lastName)")
                //.font(.headline)
            Text(athlete.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            //Spacer()
        }
        /*
        .task {
            do {
                try await items.getFavourites()
                //TODO: move this to listview for faster processing
                //determines if an athlete is a favourite or not
                if items.userFavourites.contains(where: {$0.id == athlete.id}) {
                    isFavourite = true
                }
            } catch {
                print(error)
            }
        }
         */
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

