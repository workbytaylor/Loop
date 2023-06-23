//
//  NewsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @State private var isLoggedIn: Bool = true
    @State private var showStory: Bool = false
    @State private var selectedStory: String = ""
    @StateObject private var vm = Feed()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavouritesHScrollView()
                    .padding(.top, 4)
                    .padding(.bottom, 6)
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
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
            .sheet(isPresented: $isLoggedIn) {
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
    static var previews: some View {
        HomeView()
    }
}




