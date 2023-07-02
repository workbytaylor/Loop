//
//  NewsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @State private var showStory: Bool = false
    @State private var selectedStory: String = ""
    @StateObject private var vm = Feed()
    @EnvironmentObject var session: Session
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavouritesHScrollView()
                    .padding(.vertical)
                ForEach(vm.sortedStories, id: \.link) { story in
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
            .task {
                do {
                    try await vm.getStories()
                } catch {
                    print(error)
                }
            }
            .refreshable {
                // might need to update this, works for now
                do {
                    try await vm.getStories()
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .sheet(isPresented: $session.userIsLoggedOut) {
                LoginView()
                    .interactiveDismissDisabled()
            }
            
        }
        .fullScreenCover(isPresented: $showStory) {
            NavigationStack {
                StoryView(link: $selectedStory)
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}


