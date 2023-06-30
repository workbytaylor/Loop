//
//  User.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-23.
//

import Foundation

class User: ObservableObject {
    @Published var isLoggedOut: Bool = false
    @Published var user_id: String? = nil
    @Published var email: String? = nil
    
    
}
