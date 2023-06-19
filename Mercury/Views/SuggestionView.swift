//
//  SuggestionView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-19.
//

import SwiftUI

struct SuggestionView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var country = ""
    @State private var gender = ""
    
    var body: some View {
        VStack {
            Form {
                // TODO: Make each row its own section?
                
                
                Section {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Country", text: $country)
                    Picker(selection: $gender, label: Text("Gender")) {
                        Text("male")
                        Text("female")
                        Text("non-binary")
                    }
                } header: {
                    Text("Athlete info")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // submit to supabase
                } label: {
                    Text("Submit")
                }
            }
        }
        .navigationTitle("Suggest an athlete")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SuggestionView()
        }
    }
}

