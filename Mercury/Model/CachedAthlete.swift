//
//  CachedAthlete.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-27.
//
//

import Foundation
import CoreData

@objc(CachedAthlete)
public class CachedAthlete: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID?
    @NSManaged public var firstName: String//?
    @NSManaged public var lastName: String//?
    @NSManaged public var country: String//?
    @NSManaged public var gender: String//?
    // TODO: Add index to keep display order the same
}


//FETCH REQUEST
extension CachedAthlete {
    
    // the initial fetch request
    private static var cachedAthletesFetchRequest: NSFetchRequest<CachedAthlete> {
        NSFetchRequest(entityName: "CachedAthlete")
    }
    
    // CoreData requires sort descriptors
    static func all() -> NSFetchRequest<CachedAthlete> {
        let request: NSFetchRequest<CachedAthlete> = cachedAthletesFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CachedAthlete.lastName, ascending: true)
        ]
        return request
    }
    
    //TODO: Write a function to fetch a specific athlete
    // return only true or false if the athlete is fetched
    
    //static func isFavourite() -> 
    
}
