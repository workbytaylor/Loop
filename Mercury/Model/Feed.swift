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
    
    func getStories() async throws {
        let stories: [Story] = try await client.database
            .from("stories")
            .select()
            .execute().value as [Story]
        
        //sort by date, newest first
        let sortedStories = stories.sorted {
            $0.date > $1.date
        }
        
        DispatchQueue.main.async {
            self.sortedStories = sortedStories
        }
    }
}
