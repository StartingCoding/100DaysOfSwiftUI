//
//  ContentView.swift
//  iExpense
//
//  Created by Loris on 14/02/21.
//

import SwiftUI

// MARK: Archiving SwiftObjects with Codable

struct UserCodable: Codable {
    var firstName = "Taylor"
    var lastName = "Swift"
}

struct ContentView: View {
    @State private var user = UserCodable(firstName: "Taylor", lastName: "Swift")
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack {
            Text("First Name: \(firstName)")
                .padding()
            Text("Last Name: \(lastName)")
                .padding()
            
            Button("Save User") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            .padding()
            
            Button("Show User") {
                let decoder = JSONDecoder()
                let data = UserDefaults.standard.data(forKey: "UserData") ?? Data()
                
                if let dataDecoded = try? decoder.decode(UserCodable.self, from: data) {
                    firstName = dataDecoded.firstName
                    lastName = dataDecoded.lastName
                }
            }
            .padding()
        }
    }
}

// MARK: UserDefaults
// UserDefaults are loaded when your app launches so if you store something heavy, your app will lunch slowly

struct UserDefaultsView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

// MARK: OnDelete

struct DeletingRowsView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0...numbers.count, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

// MARK: @Environment
// @Environment property wrapper can create properties that store values provided externally.

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)!")
                .padding()
            
            Divider()
            
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

struct ShowingAndHidingView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
            SheetView(name: "@StartingCoding")
        }
    }
}

// MARK: ObservableObject with Class
// If you want the functionality of @State to track local Struct but for external Classes,
// You set @Published on only the properties that push an announcement for the View that means something has changed (1st half of State)
// You set the Class with the property wrapper @ObservedObject so the View know which Class sent the notification

class UserClass: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Beggings"
}

struct ObservedObjectWithClass: View {
    @ObservedObject var user = UserClass()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

// MARK: State with Struct
// When you use @State with a Struct only its View has that data and you can change it with its Binding,
// Because you are using a Struct whenever you try to change some value inside it, Swift will rebuild the whole Struct,
// the @State property wrapper watches for changes and notice the rebuild of Struct and so it refreshes the View.
// If you try to pass an @State of a Struct to multiple views, the data is going to be copied because it's a Struct so it's not gonna work.
// If you try to use an @State with a Class, when you change with Bindings some values inside it, Swift just updates those values,
// so the @State update the data inside the Class but it doesn't notice any reuild of it so it's not gonna refresh the View.

struct UserStruct {
    var firstName = "Bilbo"
    var lastName = "Baggings"
}

struct StateWithStruct: View {
    @State private var user = UserStruct()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("Change First Name", text: $user.firstName)
            TextField("Change Last Name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
