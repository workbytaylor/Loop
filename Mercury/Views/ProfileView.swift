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
                VStack(alignment: .leading) {
                    switch session.loginStatus {
                    case .loggedOut:
                        LogInView()
                    case .loggedIn:
                        LogOutView()
                    }
                }
                //.padding(.vertical)
                
                Spacer()
                    .frame(height: 50)
                
                NavigationLink {
                    VStack(alignment: .leading) {
                        Text("About")
                            .font(.title2).bold()
                        Text("Loop is a ...")
                    }
                } label: {
                    VStack {
                        HStack {
                            Text("About")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        Divider()
                    }
                }
                
                NavigationLink {
                    VStack(alignment: .leading) {
                        Text("")
                            .font(.title2).bold()
                        Text("Loop is a ...")
                    }
                } label: {
                    VStack {
                        HStack {
                            Text("Work with Loop")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        Divider()
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static let session = Session()
    
    static var previews: some View {
        NavigationStack {
            ProfileView()
                .environmentObject(session)
        }
    }
}
