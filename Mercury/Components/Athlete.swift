//
//  Athlete.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation

struct Athlete: Identifiable {
    let id: UUID = UUID()
    let fullName: String
    let image: String?  // if no image, AthleteView shows initials on a gray circle
    
    var shortName: String {
        let components = fullName.split(separator: " ")
        guard components.count > 1 else {
            return fullName
        }
        let firstName = components.first!
        let lastName = components.last!
        let abbreviatedFirstName = "\(firstName.first!)."
        return "\(abbreviatedFirstName) \(lastName)"
    }
    
    var initials: String {
        let components = fullName.split(separator: " ")
        var result = ""
        for component in components {
            if let firstCharacter = component.first {
                result.append(firstCharacter)
            }
        }
        return result
    }
        
}

extension Athlete {
    static var sampleData: [Athlete] {
        return [
            Athlete(fullName: "Sifan Hassan", image: "SifanHassan"),
            Athlete(fullName: "Ryan Crouser", image: "RyanCrouser"),
            Athlete(fullName: "Andre DeGrasse", image: "AndreDegrasse"),
            Athlete(fullName: "Courtney Dauwalter", image: "CourtneyDauwalter"),
            Athlete(fullName: "Nikki Hiltz", image: "NikkiHiltz"),
            Athlete(fullName: "Malcolm Gladwell", image: "MalcolmGladwell")
        ]
    }
}
