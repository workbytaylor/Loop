//
//  LoggedOutView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-07-03.
//

import SwiftUI

struct LogInView: View {
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text("Log in to track your favourite athletes.")
            
            VStack {
                Button {
                    //log user in
                    showSheet = true
                } label: {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Button("Sign up") {
                    showSheet = true
                }
                .controlSize(.large)
                //.padding()
            }
        }
        .sheet(isPresented: $showSheet) {
            LoginSheetView()
                .interactiveDismissDisabled()
        }
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
