//
//  Feed.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation
import Supabase

class Stories: ObservableObject {
    @Published var all: [Story] = []
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func fetch() async throws {
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
}
