//
//  NewsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI
import WebKit

struct NewsView: View {
    @State private var isPresented: Bool = false
    @State private var selectedStory: String = ""
    
    @StateObject private var feed = Feed()
    
    var body: some View {
        NavigationStack {
            FavouritesHScrollView()
                .padding(.top, 6)
            ScrollView {
                ForEach(feed.stories, id: \.link) { story in
                    // sort by date, newest first
                    Button {
                        isPresented.toggle()
                        selectedStory = story.link
                    } label: {
                        NewsCardView(story: story)
                    }
                    .padding()
                }
                
                Text("You're all caught up")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .task {
                do {
                    try await feed.getStories()
                } catch {
                    print(error)
                }
            }
            .refreshable {
                // might need to update this, works for now
                print("Refresh")
                do {
                    try await feed.getStories()
                } catch {
                    print(error)
                }
            }
            //.navigationTitle("Mercury")
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
        }
        .fullScreenCover(isPresented: $isPresented) {
            NavigationStack {
                WebCoverView(link: $selectedStory)
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}




