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
                // TODO: on dismiss, run .task {} shown in MercuryApp
            }
            /*
            .task {
                do {
                    try await stories.fetch()
                } catch {
                    print(error)
                }
            }
             */
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



