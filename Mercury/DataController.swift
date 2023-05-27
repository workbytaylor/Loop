//
//  DataController.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-27.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "cachedFavourites")
    
    init() {
        //container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}
