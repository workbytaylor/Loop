//
//  AltSettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-25.
//

import SwiftUI

struct AltSettingsView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                user.logIn.toggle()
            } label: {
                Label {
                    Text("Log in")
                } icon: {
                    Image(systemName: "person")
                }
            }
            Spacer()
        }
        .sheet(isPresented: $user.logIn) {
            LoginView()
        }
    }
}

struct AltSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AltSettingsView()
        }
    }
}
