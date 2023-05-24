//
//  NewsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-21.
//

import SwiftUI
import WebKit

struct NewsView: View {
    //@State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @State private var articleUrl: String = ""
    @State private var isLoading: Bool = false
    
    //@State var responseItems = [Response.Item]()
    @StateObject private var feed = Feed()
    
    var body: some View {
        NavigationStack {
            //FavouritesHScrollView()
                //.padding(.top, 6)
            ScrollView {
                ForEach(feed.stories, id: \.link) { story in
                    Button {
                        //print("---LINK TAPPED---\n\(item.link)")
                        isPresented.toggle()
                        articleUrl = story.link
                    } label: {
                        NewsCardView(story: story)
                    }
                    .padding()
                }
                
                switch isLoading {
                case true:
                    ProgressView()
                case false:
                    Text("You're all caught up!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .task {
                do {
                    try await feed.getStories()
                } catch {
                    print(error)
                }
            }
            .refreshable {
                //try await loadData()
                print("Refresh")
            }
            //.navigationTitle("Mercury")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "person")
                            .font(.title3)
                            //.font(.subheadline)
                            //.symbolRenderingMode(.hierarchical)
                            //.foregroundColor(.secondary)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            NavigationStack {
                WebCoverView(link: $articleUrl)
            }
        }
        //.searchable(text: $searchText, placement: .toolbar, prompt: "Athletes, Events, etc.")
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}




