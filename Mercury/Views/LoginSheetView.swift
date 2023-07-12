//
//  LoginSheetView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-21.
//

import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    let signInApple = SignInApple()
    
    func SignInWithApple() async throws {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce
        )
    }
}


struct LoginSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var session: Session
    @State var viewModel = SignInViewModel()
    
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
                    // TODO: On login, fetch favourites, ie run the same code as on startup
                    Task {
                        do {    // order is very important: action, state change, get session
                            try await viewModel.SignInWithApple()
                            session.loginStatus = .loggedIn
                            try await session.getSession()
                            dismiss()   // careful this doesn't cause errors
                        } catch {
                            print(error)
                        }
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
            .navigationTitle("Log in or sign up")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDragIndicator(.visible)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct LoginSheetView_Previews: PreviewProvider {
    //@State static var showSheet:Bool = false
    
    static var previews: some View {
        LoginSheetView()
    }
}
