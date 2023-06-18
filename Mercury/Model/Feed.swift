//
//  Feed.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation
import Supabase

class Feed: ObservableObject {
    @Published var sortedStories: [Story] = []
    
    lazy var client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func getStories() async throws {
        do {
            //get stories from supabase
            let stories: [Story] = try await client.database
                .from("stories")
                .select()
                .execute().value as [Story]
            
            //sort by date, newest first
            let sortedStories = stories.sorted {
                $0.date > $1.date
            }
            
            //update list of sorted
            self.sortedStories = sortedStories
            
        } catch {
            throw error
        }
        
        
    }
}
