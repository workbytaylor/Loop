//
//  AuthManager.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-06-27.
//

import Foundation
import Supabase

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: Constants.supabaseURL, supabaseKey: Constants.supabaseKey)
    
    func signInWithApple(idToken: String, nonce: String) async throws {
        // may need to change '_' back to what is said in the video
        _ = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        print("user is signed out")
    }
}
