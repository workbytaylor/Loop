//
//  Athletes.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-23.
//

import Foundation
import Supabase

class Athletes: ObservableObject {
    @Published var athletes: [Athlete] = []
    @Published var userFavourites: [Athlete] = []
    @Published var searchText: String = ""
    
    var searchedAthletes: [Athlete] {
        if searchText.isEmpty {
            return athletes
        } else {
            return athletes.filter { "\($0.firstName) \($0.lastName)".localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func fetchData() async throws {
        do {
            //get athlets from Supabase
            let athletes: [Athlete] = try await client.database
                .from("athletes")
                .select()
                .order(column: "lastName", ascending: true)
                .execute().value as [Athlete]
            
            self.athletes = athletes
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func getFavourites() async throws {
        do {
            // get favourited athletes from supabase
            let favourites: [Athlete] = try await client.database
                .from("userFavourites")
                .select()
                .execute().value as [Athlete]
            
            // add to list of userFavourites
            // TODO: Add way to sort favourites so users can rearrange them
            self.userFavourites = favourites
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func addUserFavourite(athlete: Athlete) async throws {
        do {
            //TODO: code to add favourite
            // what kind of relationship am I creating between users and athletes? many to many? one to many?
            let selectedAthlete = Athlete(id: athlete.id,
                                        firstName: athlete.firstName,
                                        lastName: athlete.lastName,
                                        country: athlete.country,
                                        gender: athlete.gender)
            
            let userId = Constants.testUserId
            
        } catch {
            throw error
        }
    }
}

