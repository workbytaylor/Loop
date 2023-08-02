//
//  SuggestionView.swift
//  Loop
//
//  Created by Nilakshi Roy on 2023-06-19.
//

import SwiftUI

struct SuggestionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var athletes: Athletes
    @State private var firstName = ""
    @State private var lastName: String = ""
    @State private var country: String = ""
    //@State private var gender: String? = ""
    //@State private var dateOfBirth: Date = Date()
    
    var body: some View {
        NavigationStack {
            // TODO: on submit, insert data to supabase
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
                        //TODO: insert supabase
                        Task {
                            do {
                                try await athletes.submitSuggestion(firstName, lastName, country)
                            } catch {
                                print(error)
                            }
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationTitle("New athlete")
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static let athletes = Athletes()
    
    static var previews: some View {
        NavigationStack {
            SuggestionView()
                .environmentObject(athletes)
        }
    }
}

