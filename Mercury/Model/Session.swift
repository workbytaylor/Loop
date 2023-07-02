//
//  Session.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-29.
//

import Foundation
import Supabase

final class Session: ObservableObject {
    @Published var user_id: String?
    @Published var email: String?
    @Published var userIsLoggedOut: Bool = false
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func getSession() async throws {
        do {
            let session = try await client.auth.session
            self.user_id = session.user.id.uuidString
            self.email = session.user.email
            
            print(user_id ?? "No user_id")  //print user_id if logged in, otherwise "No user_id"
            print(email ?? "No user email")
            
        } catch {
            userIsLoggedOut = true
            print("User is logged out")
            throw error
        }
    }
}
