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
        VStack(alignment: .leading) {
            Text("Log in to track your favourite athletes.")
                .padding(.bottom)
            
            Spacer()
                .frame(height: 30)
            
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
