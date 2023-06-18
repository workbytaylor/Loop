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
    @Published var userFavourites: [FavouriteAthlete] = []
    @Published var searchText: String = ""
    
    var searchedAthletes: [Athlete] {
        if searchText.isEmpty {
            return athletes
        } else {
            return athletes.filter { "\($0.firstName) \($0.lastName)".contains(searchText) }
        }
    }
    
    lazy var client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func fetchData() async throws {
        do {
            //get athlets from Supabase
            let athletes: [Athlete] = try await client.database
                .from("athletes")
                .select()
                .execute().value as [Athlete]
            
            //sort by lastName, alphabetical
            let alphabeticalAthletes = athletes.sorted {
                $1.lastName > $0.lastName
            }
            
            //update list of athletes
            self.athletes = alphabeticalAthletes
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func getFavourites() async throws {
        do {
            // get favourited athletes from supabase
            let favourites: [FavouriteAthlete] = try await client.database
                .from("userFavourites")
                .select()
                .execute().value as [FavouriteAthlete]
            
            // add to list of userFavourites
            self.userFavourites = favourites
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func addUserFavourite(athlete: Athlete) async throws {
        do {
            //TODO: code to add favourite
            // change to favouriteAthlete?
            // get athlete, convert to favourite, insert() to supabase
            let selectedAthlete = Athlete(id: athlete.id,
                                        firstName: athlete.firstName,
                                        lastName: athlete.lastName,
                                        country: athlete.country,
                                        gender: athlete.gender)
            
            let userId = Constants.testUserId
            let newAthleteToFavourite = FavouriteAthlete(userId: userId,
                                                         id: athlete.id,
                                                         firstName: athlete.firstName,
                                                         lastName: athlete.lastName)
            
            
        } catch {
            throw error
        }
    }
}

