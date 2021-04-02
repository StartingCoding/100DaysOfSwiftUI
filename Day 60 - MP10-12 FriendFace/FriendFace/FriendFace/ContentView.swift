//
//  ContentView.swift
//  FriendFace
//
//  Created by Loris on 24/03/21.
//

// https://www.hackingwithswift.com/samples/friendface.json

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var users: Users
    
    var body: some View {
        NavigationView {
            UsersView(users: $users.users)
                .navigationBarTitle(Text("FriendFace"))
        }
        .onAppear(perform: users.downloadData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
