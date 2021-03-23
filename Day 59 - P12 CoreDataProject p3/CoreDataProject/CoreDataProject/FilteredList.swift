//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Loris on 22/03/21.
//

import SwiftUI
import CoreData

enum PredicateFilter {
    case beginsWith(String)
    case beginsWithCaseSensitive(String)
    case isEqualTo(String)
    case isLessThan(String)
}

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: PredicateFilter, sortingDescriptors: [NSSortDescriptor]) {
        let chosenFilter: String
        let chosenOption: String
        
        switch filter {
        case .beginsWith(let letter):
            chosenFilter = letter
            chosenOption = "BEGINSWITH"
        case .isEqualTo(let word):
            chosenFilter = word
            chosenOption = "=="
        case .isLessThan(let letter):
            chosenFilter = letter
            chosenOption = "<"
        case .beginsWithCaseSensitive(let letter):
            chosenFilter = letter.lowercased()
            chosenOption = "BEGINSWITH[c]"
        }
        
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortingDescriptors, predicate: NSPredicate(format: "lastName %K %@", chosenOption , chosenFilter))
    }
}


// MARK: FilteredListGeneric
struct FilteredListGeneric<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        List(singers, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
