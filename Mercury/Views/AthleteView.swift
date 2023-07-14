//
//  AthleteView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    @State var athlete: Athlete
    @State private var isPresented: Bool = false
    @State private var selectedStory: String = ""
    @ObservedObject private var feed = Stories()
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
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
                Text("placeholder to test scrolling")
                ForEach(feed.all, id: \.link) { story in
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if let index = athlete.index {
                        switch athletes.all[index].isFavourite {
                        case true?:
                            deleteFavourite()
                        case false?:
                            addFavourite()
                        case .none:
                            addFavourite()
                        }
                    } else {
                        // show notification to sign up
                    }
                    //isFavourite.toggle()
                    //TODO: Add or remove from userFavourites table as required
                } label: {
                    if let index = athlete.index {
                        Image(systemName: athletes.all[index].isFavourite == true ? "heart.fill" : "heart")
                    }
                }
            }
        }
    }
    
    private func addFavourite() {
        Task {
            if let index = athlete.index {
                // mark favourite
                athletes.all[index].isFavourite = true
                
                // add to favourites table
                // TODO: crashes if user not logged in?
                try await athletes.addFavourite(athlete: index, user_id: UUID(uuidString: session.user_id!)!)
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
    static var previews: some View {
        NavigationStack {
            AthleteView(athlete: Athlete(id: UUID(),
                                         firstName: "Taylor",
                                         lastName: "Schaefer",
                                         country: "Canada",
                                         gender: "male",
                                         isPopular: true))
        }
    }
}



