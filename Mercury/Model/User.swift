//
//  User.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-23.
//

import Foundation

@MainActor class User: ObservableObject {
    @Published var isLoggedOut: Bool = true
}
