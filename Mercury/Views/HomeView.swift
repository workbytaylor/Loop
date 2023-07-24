//
//  NewsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @Binding var showSignInSheet: Bool
    @State private var showStory: Bool = false
    @State private var selectedStory: String = ""
    @EnvironmentObject var athletes: Athletes
    @EnvironmentObject var stories: Stories
    @EnvironmentObject var session: Session
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavouritesHScrollView()
                    .padding(.vertical)
                ForEach(stories.all, id: \.link) { story in
                    Button {
                        showStory.toggle()
                        selectedStory = story.link
                    } label: {
                        NewsCardView(story: story)
                    }
                    .padding(.horizontal)
                    .padding(.bottom).padding(.bottom)
                }
            }
            .sheet(isPresented: $showSignInSheet) {
                LoginSheetView()
                    .interactiveDismissDisabled()
            }
            .onChange(of: session.loginStatus) {newValue in
                if session.loginStatus == .loggedIn {
                    Task {
                        do {
                            try await athletes.getFavourites(user_id: session.user_id)
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    Task {
                        do {
                            try await athletes.getAthletes()
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
            .refreshable {
                // stories.fetch()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showStory) {
            NavigationStack {
                StoryView(link: $selectedStory)
            }
        }
    }
    
    
    func sheetDismissed(user_id: String?) {
        Task {
            do {
                try await athletes.getFavourites(user_id: session.user_id)
            } catch {
                print(error)
            }
        }
    }
    
    
}

struct NewsView_Previews: PreviewProvider {
    static let athletes = Athletes()
    static let stories = Stories()
    
    static var previews: some View {
        HomeView(showSignInSheet: .constant(false))
            .environmentObject(athletes)
            .environmentObject(stories)
    }
        
}



