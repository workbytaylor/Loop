//
//  AthleteView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    let athlete: Athlete
    
    var body: some View {
        VStack {
            Text(athlete.initials)
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
            
            Text(athlete.fullName)
                .font(.headline)
                //.foregroundColor(.primary)
            Spacer()
        }
    }
}

/*
struct AthleteThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteView(athlete: <#Athlete#>)
    }
}


*/
