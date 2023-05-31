//
//  Athletes.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-23.
//

import Foundation
import Supabase

class Athletes: ObservableObject {
    @Published var all: [Athlete] = []
    @Published var userFavourites: [Athlete] = []
    
    lazy var client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    func getAll() async throws {
        let athletes: [Athlete] = try await client.database
            .from("athletes")
            .select()
            .execute().value as [Athlete]
        
        DispatchQueue.main.async {
            self.all = athletes
        }
    }
    
    func getFavourites() async throws {
        let favourites: [Athlete] = try await client.database
            .from("userFavourites")
            .select()
            .execute().value as [Athlete]
        
        DispatchQueue.main.async {
            self.userFavourites = favourites
        }
    }
    
    
}

