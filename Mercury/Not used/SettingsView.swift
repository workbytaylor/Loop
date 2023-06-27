//
//  SettingsView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

// TODO: Change style from list to VStack

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        List {
            Section {
                Button {
                    UIApplication.shared.open(URL(string: "https://bento.me/workbytaylor")!)
                } label: {
                    Label {
                        HStack {
                            Text("Created by Taylor Schaefer ")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .foregroundStyle(.tertiary)
                                .bold()
                        }
                        
                    } icon: {
                        Image(systemName: "wrench.and.screwdriver")
                    }
                }
                
                Button {
                    //send email
                    // TODO: Replace with sneding text to table in supabase
                    if let url = URL(string: "mailto:workbytaylor@gmail.com") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                } label: {
                    Label {
                        Text("Share feedback")
                    } icon: {
                        Image(systemName: "paperplane")
                    }
                }
            } header: {
                Text("About")
            }
            
            Section {
                //TODO: replace tracksmith with app store link
                ShareLink("Send to a friend", item: URL(string: "https://www.tracksmith.com")!)
                
            } header: {
                Text("Spread the love")
            }
            
            Section {
                Button {
                    user.isLoggedOut.toggle()
                } label: {
                    Label {
                        Text("Log in")
                    } icon: {
                        Image(systemName: "person")
                    }
                }
            } header: {
                Text("Account")
            }
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $user.isLoggedOut) {
            LoginView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @StateObject var user = User()
    
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
