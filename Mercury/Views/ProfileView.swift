//
//  AltSettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: Session
    
    var body: some View {
        NavigationStack {
            ScrollView {
                switch session.loginStatus {
                case .loggedOut:
                    LogInView()
                case .loggedIn:
                    LogOutView()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Profile")
        }
    }
}

struct AltSettingsView_Previews: PreviewProvider {
    @StateObject var session: Session = Session()
    
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
