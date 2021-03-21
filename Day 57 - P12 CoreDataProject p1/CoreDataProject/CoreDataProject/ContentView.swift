//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Loris on 21/03/21.
//

import SwiftUI
import CoreData

// MARK: Unique CoreData Objects using Constraints

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: Conditional Saving for NSManagedObjectContext

struct ConditionalSavingView: View {
    @Environment(\.managedObjectContext) var moc
    
    // Asking if in the context there are any object with some changes
    // before trying to save something, let's us optimize CoreData
    var body: some View {
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

// MARK: Hashable
// single fixed output generated from some variable input
// We can make a custom struct conform to Hashable
// if the properties inside conform to Hashable

struct Student: Hashable {
    let name: String
}

struct HashableView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
