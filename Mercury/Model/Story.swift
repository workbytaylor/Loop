//
//  Story.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation

struct Story: Identifiable, Codable {
    let id: UUID
    let title: String
    let link: String
    let displayLink: String
    let image: String
    let date: String  //TODO: unsure if this should be date, or string?
}
