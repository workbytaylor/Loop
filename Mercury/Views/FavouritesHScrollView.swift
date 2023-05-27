//
//  FavouritesHScrollView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI
import CoreData

struct FavouritesHScrollView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CachedAthlete.all()) private var favouriteAthletes
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                
                ForEach(favouriteAthletes) { athlete in
                    Text(athlete.firstName)
                }
                
                VStack {
                    NavigationLink {
                        FavouritesListView()
                    } label: {
                        Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.headline)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
                    
                    Text("Favourites")
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct FavouritesHScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesHScrollView()
    }
}
