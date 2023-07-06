//
//  FavouritesHScrollView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI
import CoreData

struct FavouritesHScrollView: View {
    @StateObject private var athletes = Athletes()
    //likely a better way
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                /*
                ForEach(athletes.userFavourites) { athlete in
                    NavigationLink {
                        AthleteView(athlete: athlete)
                    } label: {
                        VStack {
                            Text(athlete.initials)
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .clipShape(Circle())
                            Text(athlete.shortName)
                                .font(.caption2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                */
                FavouritesListButtonView()
            }
            .padding(.horizontal)
        }/*
        .task {
            do {
                //try await vm.getFavourites()
            } catch {
                print(error)
            }
        }
          */
    }
}

struct FavouritesHScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesHScrollView()
    }
}
