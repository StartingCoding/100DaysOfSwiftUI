//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Loris on 24/03/21.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Users())
        }
    }
}
