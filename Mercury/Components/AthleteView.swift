//
//  AthleteView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    //TODO: change below var/let to var athlete: Athlete
    let shortName: String
    let image: String?
    let initials: String
    
    var body: some View {
        Text("")
        /*
        VStack {
            if let image = image {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Text(initials)
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            Text(shortName)
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.caption2)
                .foregroundColor(.primary)
                
        }
        .frame(width: 60)
    */
    }
}

struct AthleteThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteView(shortName: "S. Hassan", image: "SifanHassan", initials: "SF")
    }
}



