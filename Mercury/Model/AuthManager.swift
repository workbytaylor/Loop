//
//  AuthManager.swift
//  Mercury
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
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        print(session)
        print(session.user)
    }
    
}
