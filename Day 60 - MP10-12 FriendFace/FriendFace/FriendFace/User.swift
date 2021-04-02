//
//  User.swift
//  FriendFace
//
//  Created by Loris on 25/03/21.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friends: Codable, Identifiable {
        var id: UUID
        var name: String
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friends]
    
    var wrappedIsActive: String {
        isActive ? "Online" : "Offline"
    }
}
