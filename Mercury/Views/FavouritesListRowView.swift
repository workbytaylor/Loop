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
    }
}

/*
struct FavouritesListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesListRowView(athlete: Athlete()
    }
}
*/
