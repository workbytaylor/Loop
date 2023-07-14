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
    @State private var selectedPage: Page = .info
    @State private var selectedStory: String = ""
    @ObservedObject private var feed = Stories()
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var session: Session
    
    enum Page: String, CaseIterable, Identifiable {
        var id: Self { self }
        case stories
        case info
    }
    
    var body: some View {
        VStack {
            Text(athlete.initials)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                .background(Color.gray)
                .clipShape(Circle())
            
            Picker("Context", selection: $selectedPage) {
                ForEach(Page.allCases) { page in
                    Text(page.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView {
                // TODO: Update feed to show stories
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
        .navigationTitle(athlete.fullName)
        .navigationBarTitleDisplayMode(.inline)
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
                        // show notification to sign up
                    }
                } label: {
                    if let index = athlete.index {
                        Image(systemName: athletes.all[index].isFavourite == true ? "heart.fill" : "heart")
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



