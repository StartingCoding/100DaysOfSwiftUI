//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Loris on 21/03/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
}

extension Movie : Identifiable {

}
