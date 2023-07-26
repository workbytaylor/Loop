//
//  Athletes.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-05-23.
//

import Foundation
import Supabase

struct Athlete: Identifiable, Codable, Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let country: String
    let gender: String  // male, female, non-binary
    var isFavourite: Bool?
    let isPopular: Bool?
    var index: Int?
    
    var initials: String {
        let first = String(firstName.prefix(1))
        let last = String(lastName.prefix(1))
        return first + last
    }
    
    var shortName: String {
        let first = String(firstName.prefix(1))
        return "\(first). \(lastName)"
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

struct Favourite: Identifiable, Codable, Hashable {
    let id: UUID?
    let user_id: UUID?
    let athlete_id: UUID
}

struct Suggestion: Codable, Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    let country: String
}


class Athletes: ObservableObject {
    @Published var all: [Athlete] = []
    @Published var userFavouriteIDs: [Favourite] = []
    @Published var searchText: String = ""
    
    var searchedAthletes: [Athlete] {
        if searchText.isEmpty {
            return all.filter { $0.isPopular == true }  //show popular names to start, full list still searchable
        } else {
            return all.filter { "\($0.firstName) \($0.lastName)".localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var favouriteAthletes: [Athlete] {
        return all.filter { $0.isFavourite == true }
    }
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func getAthletes() async throws {
        do {
            //get athletes from Supabase
            let athletes: [Athlete] = try await client.database
                .from("athletes")
                .select()
                .order(column: "lastName", ascending: true)
                .execute().value as [Athlete]
            self.all = athletes
            
            // mark index of each athlete
            for (index, athlete) in zip(all.indices, all) {
                var updatedAthlete = athlete
                updatedAthlete.index = index
                self.all[index] = updatedAthlete
            }
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func getFavourites(user_id: String?) async throws {
        do {
            //get athlete_id for user favourites
            guard let unwrapped_user_id = user_id else {
                print("returned")
                return
            }
            
            let userFavourites: [Favourite] = try await client.database
                .from("favourites")
                .select()
                .eq(column: "user_id", value: unwrapped_user_id) // can unwrap because function throws errors
                .execute().value as [Favourite]
            self.userFavouriteIDs = userFavourites
            
            // mark favourite athletes in list of all athletes
            for athlete in self.all {
                for favourite in userFavourites {
                    if athlete.id == favourite.athlete_id {
                        var updatedAthlete = athlete
                        updatedAthlete.isFavourite = true
                        self.all[athlete.index!] = updatedAthlete
                        
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
    @MainActor
    func addFavourite(athlete: Int, user_id: UUID) async throws {
        // adds athlete_id and user_id to favourites table
        self.all[athlete].isFavourite = true
        
        do {
            let favouriteToAdd = Favourite(id: nil,
                                           user_id: user_id,
                                           athlete_id: self.all[athlete].id)
            try await client.database
                .from("favourites")
                .insert(values: favouriteToAdd)
                .execute()
        } catch {
            throw error
        }
    }
    
    @MainActor
    func removeFavourite(athlete_id: UUID) async throws {
        // removes athlete_id and user_id from favourites table
        do {
            try await client.database
                .from("favourites")
                .delete()
                .eq(column: "athlete_id", value: athlete_id.uuidString)
                .execute()
        } catch {
            throw error
        }
        
        // TODO: unmark athlete as favourite / refresh favourites?
        // TODO: delete athlete from favouriteAthletes
    }
    
    func submitSuggestion(_ first: String, _ last: String, _ country: String) async throws {
        let suggestion = Suggestion(id: UUID(), firstName: first, lastName: last, country: country)
        //TODO: add user_id to the table
        
        try await client.database
            .from("suggested_athletes")
            .insert(values: suggestion)
            .execute()
    }
    
}

