//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Loris on 02/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}


// MARK: Network call with URLSession using Codable
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct NetworkCallView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id:\.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        // Creating the URL we want to read
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // Wrapping the URL in a URLRequest, which allow us to control how the URL should be accessed
        let request = URLRequest(url: url)
        
        // Create and start a networking task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data - go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        results = decodedResponse.results
                    }
                    
                    // everything is good so we can exit
                    return
                }
                
                // if we're still here it means there was a problem
                print("🔴 Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}


// MARK: Implementing Codable on @Published
class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Starting Coding"
    
    // Init for Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    // Method to Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
