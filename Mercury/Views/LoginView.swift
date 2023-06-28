//
//  LoginView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-21.
//

import SwiftUI

//TODO: class LogInViewModel
// start video at 27:07


struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    let signInWithApple = SignInWithApple()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading) {
                    Text("Loop")
                        .font(.title)
                        .bold()
                    Text("Track & field news from around the world.")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    // sign in
                    func signInWithApple() async throws {
                        let appleResult = try await signInWithApple.startSignInWithAppleFlow()
                        try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
                    }
                } label: {
                    Text("Continue with Apple")
                        .frame(maxWidth: .infinity)
                        .bold()
                        .overlay {
                            HStack {
                                Image(systemName: "applelogo")
                                Spacer()
                            }
                        }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
            .navigationTitle("Login or sign up")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDragIndicator(.visible)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        user.isLoggedOut = false
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
