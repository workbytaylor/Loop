//
//  Feed.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation
import Supabase
import PostgREST

struct Story: Identifiable, Codable {
    let id: UUID
    let title: String
    let link: String
    let displayLink: String
    let image: String
    let date: String  //date does not work currently
    var tags: [String]?
}

class Stories: ObservableObject {
    @Published var all: [Story] = []
    @Published var forFavourites: [Story] = []
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func getAll() async throws {
        do {
            //get stories from supabase
            let stories: [Story] = try await client.database
                .from("stories")
                .select()
                .order(column: "date", ascending: false)
                .execute().value as [Story]
            
            self.all = stories
            
        } catch {
            throw error
        }
    }
    
    // TODO: bug with .overlaps() in supabase
    /*
    @MainActor
    func getStoriesForFavourites(/*fullName: String*/) async throws {
        do {
            let storiesForFavourites: [Story] = try await client.database
                .from("stories")
                .select()
                .overlaps(column: "tags", value: "Yared Nuguse")
                .execute().value as [Story]
            
            self.forFavourites = storiesForFavourites
            
        } catch {
            throw error
        }
    }
    */
    
}
