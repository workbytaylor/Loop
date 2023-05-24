//
//  Athlete.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation

struct Athlete: Identifiable, Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let country: String
}
