//
//  Constants.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import Foundation

enum Constants {
    static let supabaseURL: URL = URL(string: "https://irkvfgnzxzjabyhubmqg.supabase.co")!
    static let supabaseKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlya3ZmZ256eHpqYWJ5aHVibXFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQxNDQyODMsImV4cCI6MTk5OTcyMDI4M30.eF39Qu0hlM7bm75sTJ0KmAZ6xgBSdP-qz-vzKOk7uAM"
    
    // to simulate a user's UUID for building/debugging
    static let testUserId: UUID = UUID(uuidString: "9e0ab71f-cfc2-4ce7-b711-86b8ae29150f")!
    
    
}
