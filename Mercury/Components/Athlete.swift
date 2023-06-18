//
//  Athlete.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation

struct Athlete: Identifiable, Codable, Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let country: String
    let gender: String
    
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

// is this really necessary to add a favourite?
struct FavouriteAthlete: Identifiable, Codable, Hashable {
    let userId: UUID
    let id: UUID
    let firstName: String
    let lastName: String
}


// TODO: Favourites and Athletes should match exactly??? Otherwise how do I get athletes to show in favourites?
