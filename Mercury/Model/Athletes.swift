//
//  Athletes.swift
//  Mercury
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
    let gender: String
    var isFavourite: Bool?
    
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
    let id: UUID
    let user_id: UUID
    let athlete_id: UUID
}


class Athletes: ObservableObject {
    @Published var athletes: [Athlete] = []
    @Published var userFavourites: [Favourite] = []
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
    func getAthletes(user_id: String?) async throws {
        do {
            //get athletes from Supabase
            let athletes: [Athlete] = try await client.database
                .from("athletes")
                .select()
                .order(column: "lastName", ascending: true)
                .execute().value as [Athlete]
            
            self.athletes = athletes
            
        } catch {
            throw error
        }
        
        do {
            //get user favourites
            let userFavourites: [Favourite] = try await client.database
                .from("favourites")
                .select()
                .eq(column: "user_id", value: user_id!) // can unwrap because this throws errors
                .execute().value as [Favourite]
            
            self.userFavourites = userFavourites
            
            /*
            for var athlete in athletes {
                for favourite in userFavourites {
                    if athlete.id == favourite.athlete_id {
                        athlete.isFavourite = true
                        
                        print(athlete)
                        // need to update athlete in list of all athletes
                    }
                }
            }
            */
            for (index, athlete) in athletes.enumerated() {
                for favourite in userFavourites {
                    if athlete.id == favourite.athlete_id {
                        var updatedAthlete = athlete
                        updatedAthlete.isFavourite = true
                        self.athletes[index] = updatedAthlete
                    }
                }
            }
            
        } catch {
            throw error
        }
    }
    /*
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
    */
    
}

