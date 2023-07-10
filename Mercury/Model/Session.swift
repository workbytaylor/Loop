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
    @Published var showLogin: Bool = false
    @Published var loginStatus: loginState = .loggedOut
    
    enum loginState {
        case loggedIn
        case loggedOut
    }
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    @MainActor
    func getSession() async throws {
        do {
            let session = try await client.auth.session
            self.loginStatus = .loggedIn
            self.user_id = session.user.id.uuidString
            self.email = session.user.email
            
            print(loginStatus)
            print(email as Any)
            print(user_id as Any)
            
        } catch {
            //print("User is logged out")
            throw error
        }
    }
}
