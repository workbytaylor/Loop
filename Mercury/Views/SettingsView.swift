//
//  AltSettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-25.
//

import SwiftUI

struct SettingsView: View {
    @State private var showSheet: Bool = false
    @EnvironmentObject var session: Session
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text("Log in to track your favourite athletes.")
                    
                    switch session.userIsLoggedOut {
                    case false:
                        VStack {
                            Button {
                                showSheet.toggle()
                            } label: {
                                Text("Log in")
                                    .frame(maxWidth: .infinity)
                                    .bold()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            
                            Button("Sign up") {
                                showSheet.toggle()
                            }
                            .controlSize(.large)
                            //.padding()
                        }
                    case true:
                        Button {
                            //Log user out
                            Task {
                                do {
                                    try await AuthManager.shared.signOut()
                                } catch {
                                    print("error signing out")
                                }
                            }
                            session.userIsLoggedOut = true
                        } label: {
                            Text("Log out")
                                .frame(maxWidth: .infinity)
                                .bold()
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        
                    }
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                print(session.user_id ?? "no user")
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showSheet) {
                LoginView()
            }
        }
    }
}

struct AltSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
