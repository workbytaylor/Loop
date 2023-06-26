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
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    //VStack(alignment: .leading) {
                        Text("Log in to track your favourite athletes.")
                    //}
                    
                    Button {
                        user.logIn.toggle()
                    } label: {
                        Label {
                            Text("Log in")
                                .frame(maxWidth: .infinity)
                                .bold()
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    Spacer()
                    
                }
                
                .padding()
                
                
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $user.logIn) {
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
