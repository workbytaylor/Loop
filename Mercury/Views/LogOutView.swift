//
//  ProfileLoggedInView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-07-03.
//

import SwiftUI

struct LogOutView: View {
    @EnvironmentObject var session: Session
    
    var body: some View {
        Button {    //Log user out
            Task {
                do {    // order is very important: action, state change, get session   // changed for logout only, makes app snappier
                    session.loginStatus = .loggedOut
                    try await AuthManager.shared.signOut()
                    try await session.getSession()
                } catch {
                    print(error)
                }
                
            }
        } label: {
            Text("Log out")
                .frame(maxWidth: .infinity)
                .bold()
                .foregroundColor(.red)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

struct ProfileLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LogOutView()
    }
}
