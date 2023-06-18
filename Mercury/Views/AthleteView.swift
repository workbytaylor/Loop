//
//  AthleteView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    let athlete: Athlete
    @State private var isPresented: Bool = false
    @State private var selectedStory: String = ""
    @ObservedObject private var feed = Feed()
    
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
            
            ScrollView {
                ForEach(feed.sortedStories, id: \.link) { story in
                    Button {
                        isPresented.toggle()
                        selectedStory = story.link
                    } label: {
                        NewsCardView(story: story)
                    }
                    .padding(.horizontal)
                    .padding(.bottom).padding(.bottom)
                }
            }
            /*
             // get stories tagged with this athlete
            .task {
                do {
                    try await feed.getStories()
                } catch {
                    print(error)
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                NavigationStack {
                    WebCoverView(link: $selectedStory)
                }
            }
             */
        }
    }
}


struct AthleteThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AthleteView(athlete: Athlete(id: UUID(), firstName: "Taylor", lastName: "Schaefer", country: "Caanda", gender: "male"))
        }
    }
}



