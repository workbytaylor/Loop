//
//  LoginView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-21.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Loop")
                .font(.title).bold()
            Text("The latest track and field news from around the world.")
                .font(.headline)
            Spacer()
            
            
            
            
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(width: .infinity, height: 50)
            
            Spacer()
            
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
