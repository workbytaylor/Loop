//
//  Favourites.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-23.
//

import Foundation
import Supabase

class Favourites: ObservableObject {
    @Published var athletes: [Athlete] = []
    
    lazy var client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    func getAthletes() async throws {
        let athletes: [Athlete] = try await client.database
            .from("athletes")
            .select()
            .execute().value as [Athlete]
        
        DispatchQueue.main.async {
            self.athletes = athletes
        }
            
        
    }
}
