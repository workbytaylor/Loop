//
//  SuggestionView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-06-19.
//

import SwiftUI

struct SuggestionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var firstName = ""
    @State private var lastName: String = ""
    @State private var country: String = ""
    //@State private var gender: String? = ""
    //@State private var dateOfBirth: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("First name", text: $firstName)
                        TextField("Last name", text: $lastName)
                    }
                    
                    Section {
                        TextField("Country", text: $country)
                    }
                    /*
                    Section {
                        Picker(selection: $gender, label: Text("Gender")) {
                            Text("--").tag("")
                            Text("Female").tag("female")
                            Text("Male").tag("male")
                            Text("Non-Binary").tag("non-binary")
                        }
                    }
                    
                    Section {
                        DatePicker("Date of Birth",
                                   selection: $dateOfBirth,
                                   displayedComponents: [.date])

                    }
                    */
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // submit to supabase
                        dismiss()
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                    }
                }
            }
            .navigationTitle("New athlete")
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SuggestionView()
        }
    }
}

