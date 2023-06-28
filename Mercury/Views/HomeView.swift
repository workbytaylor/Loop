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
    @EnvironmentObject var user: User
    
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
                //print("Refresh")
                do {
                    try await vm.getStories()
                } catch {
                    print(error)
                }
            }
            //.navigationTitle("News")
            //.navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $user.isLoggedOut/*, onDismiss: {
                user.showLogInSheet = false
            }*/) {
                LoginView()
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
    @StateObject var user = User()
    
    static var previews: some View {
        HomeView()
    }
}


