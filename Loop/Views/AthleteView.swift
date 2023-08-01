//
//  AthleteView.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    @State var athlete: Athlete
    @State private var isPresented: Bool = false
    @State private var selectedStory: String = ""
    @State private var storiesForThisAthlete: [Story] = []
    @EnvironmentObject var stories: Stories
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
    var body: some View {
        ScrollView {
            Text(athlete.initials)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                .background(Color.gray)
                .clipShape(Circle())
        
            Text(athlete.fullName)
                .font(.title).bold()
            
            if storiesForThisAthlete.isEmpty {
                VStack {
                    Text("Nothing yet, come back later!")
                }
                .padding(.top, 50)
                .font(.subheadline)
                //.foregroundStyle(.secondary)
                
            } else {
                ForEach(storiesForThisAthlete, id: \.link) { story in
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
            
        }
        .task {
            // filter stories for athletes
            let filteredStories = stories.all.filter { story in
                return story.title.contains(athlete.fullName)
            }
            storiesForThisAthlete = filteredStories
        }
        
        .fullScreenCover(isPresented: $isPresented) {
            NavigationStack {
                StoryView(link: $selectedStory)
            }
        }
         
        //.navigationTitle(athlete.fullName)
        //.navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if let index = athlete.index {
                        switch athletes.all[index].isFavourite {
                        case true?:
                            deleteFavourite()
                        case false?:
                            Task {
                                try await athletes.addFavourite(athlete: index, user_id: UUID(uuidString: session.user_id!)!)
                            }
                        case .none:
                            Task {
                                try await athletes.addFavourite(athlete: index, user_id: UUID(uuidString: session.user_id!)!)
                            }
                        }
                    } else {
                        // TODO: show notification to sign up
                    }
                } label: {
                    if let index = athlete.index {
                        if athletes.all[index].isFavourite == true {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                        } else {
                            Image(systemName: "heart")
                        }
                    } else {
                        Image(systemName: "heart")
                    }
                }
            }
        }
    }
    
    private func deleteFavourite() {
        Task {
            // mark not favourite
            if let index = athlete.index {
                athletes.all[index].isFavourite = false
            }
            
            // remove from favourites table in supabase
            try await athletes.removeFavourite(athlete_id: athlete.id)
        }
    }
}


struct AthleteThumbnailView_Previews: PreviewProvider {
    static let athletes = Athletes()
    static let session = Session()
    static let stories = Stories()
    
    static var previews: some View {
        NavigationStack {
            AthleteView(athlete: Athlete(id: UUID(),
                                         firstName: "Taylor",
                                         lastName: "Schaefer",
                                         country: "Canada",
                                         gender: "male",
                                         isPopular: true))
            .environmentObject(athletes)
            .environmentObject(session)
            .environmentObject(stories)
        }
    }
}



