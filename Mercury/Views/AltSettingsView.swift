//
//  AltSettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-25.
//

import SwiftUI

struct AltSettingsView: View {
    @EnvironmentObject var user: User
    @State private var showSheet: Bool = false
    @State private var loggedOut: Bool?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text("Log in to track your favourite athletes.")
                    
                    if loggedOut == false {
                        Button {
                            //Log user out
                            loggedOut = true
                        } label: {
                            Text("Log out")
                                .frame(maxWidth: .infinity)
                                .bold()
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        //.tint(Color.red)
                        
                    } else {
                        VStack {
                            Button {
                                //user.isLoggedOut.toggle()
                                showSheet.toggle()
                            } label: {
                                Text("Log in")
                                    .frame(maxWidth: .infinity)
                                    .bold()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            
                            Button("Sign up") {
                                //user.showLogInSheet.toggle()
                                showSheet.toggle()
                            }
                            .controlSize(.large)
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showSheet, onDismiss: {
                loggedOut = false
            }) {
                LoginView()
            }
        }
    }
}

struct AltSettingsView_Previews: PreviewProvider {
    @StateObject var user = User()
    
    static var previews: some View {
        NavigationStack {
            AltSettingsView()
        }
    }
}
