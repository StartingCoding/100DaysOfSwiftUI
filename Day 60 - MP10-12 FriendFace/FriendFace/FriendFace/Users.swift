//
//  Friends.swift
//  FriendFace
//
//  Created by Loris on 25/03/21.
//

import Foundation

class Users: ObservableObject {
    @Published var users = [User]()
    
    func downloadData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error")
                return
            }
            
            if let dataDecoded = try? JSONDecoder().decode([User].self, from: data) {
                for user in dataDecoded {
                    DispatchQueue.main.async {
                        self.users.append(user)
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        .resume()
    }
}
