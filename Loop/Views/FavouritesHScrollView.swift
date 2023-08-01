//
//  FavouritesHScrollView.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct FavouritesHScrollView: View {
    @EnvironmentObject  var athletes: Athletes
    private var size: CGFloat = 60
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(athletes.favouriteAthletes) { athlete in
                    NavigationLink {
                        AthleteView(athlete: athlete)
                    } label: {
                        VStack {
                            Text(athlete.initials)
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(width: size, height: size)
                                .background(Color.gray)
                                .clipShape(Circle())
                            Text(athlete.shortName)
                                .lineLimit(1)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .clipped()
                                
                        }
                        .frame(width: size)
                    }
                }
                
                FavouritesListButtonView()
            }
            .padding(.horizontal)
        }
    }
}

struct FavouritesHScrollView_Previews: PreviewProvider {
    static let athletes = Athletes()
    
    static var previews: some View {
        FavouritesHScrollView()
            .environmentObject(athletes)
    }
}
