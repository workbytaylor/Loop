//
//  AthleteView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct AthleteView: View {
    @State var index: Int
    @State private var isPresented: Bool = false
    @State private var selectedStory: String = ""
    @State private var isFavourite: Bool = false
    @ObservedObject private var feed = Stories()
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
    var body: some View {
        VStack {
            Text(athletes.all[index].initials)
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
            Text(athletes.all[index].fullName)
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
        .task {
            if athletes.all[index].isFavourite == true {
                isFavourite = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    switch athletes.all[index].isFavourite {
                    case true?:
                        deleteFavourite()
                    case false?:
                        addFavourite()
                    case .none:
                        addFavourite()
                    }
                    
                    
                    //isFavourite.toggle()
                    //TODO: Add or remove from userFavourites table as required
                } label: {
                    Image(systemName: isFavourite == true ? "heart.fill" : "heart")
                }
            }
        }
    }
    
    private func addFavourite() {
        Task {
            // mark favourite
            athletes.all[index].isFavourite = true
            //if let index = athlete.index {
              //  athletes.allAthletes[index].isFavourite = true
            //}
            
            // add to favourites table
            try await athletes.addFavourite(athlete: athletes.all[index], user_id: UUID(uuidString: session.user_id!)!) // pass index only? modify function in athletes? same for below?
        }
    }
    
    private func deleteFavourite() {
        Task {
            // mark not favourite
            athletes.all[index].isFavourite = false
            //if let index = athlete.index {
              //  athletes.allAthletes[index].isFavourite = false
            //}
            
            // remove from favourites table in supabase
            try await athletes.removeFavourite(athlete_id: athlete.id)
        }
    }
    
}


struct AthleteThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AthleteView(index: 0,
                        athletes: Athlete(id: UUID(),
                                         firstName: "Taylor",
                                         lastName: "Schaefer",
                                         country: "Caanda",
                                         gender: "male",
                                         isPopular: false,
                                         index: nil))
        }
    }
}



