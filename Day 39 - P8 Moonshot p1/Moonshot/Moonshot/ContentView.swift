//
//  ContentView.swift
//  Moonshot
//
//  Created by Loris on 17/02/21.
//

import SwiftUI

// MARK: Codable
struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

// MARK: NavigationView and NavigationLink
struct NavigationViewNavigationLink: View {
    var body: some View {
        NavigationView {
            VStack {
                List(0..<100) { row in
                    NavigationLink(destination: Text("Detail \(row)")) {
                        Text("\(row)")
                    }
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

// MARK: ScrollView
struct ScrollView: View {
    var body: some View {
//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
                List {
                    ForEach(0..<100) {
                        CustomText("Item \($0)")
                            .font(.title)
                    }
                }
//            }
//            .frame(maxWidth: .infinity)
//        }
    }
}

// MARK: GeometryReader and Image
struct GeometryReaderWithImage: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("example")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
//                    .clipped()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
