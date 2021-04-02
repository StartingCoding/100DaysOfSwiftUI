//
//  FriendsList.swift
//  FriendFace
//
//  Created by Loris on 30/03/21.
//

import SwiftUI

struct FriendsList: View {
    var friends: [User.Friends]
    var userName: String
    
    var body: some View {
        VStack {
            List(friends) { friend in
                NavigationLink(destination: DetailFriend(friendName: friend.name)) {
                    Label(friend.name, systemImage: "person.crop.circle")
                        .padding()
                        .font(.title)
                }
            }
        }
        .navigationBarTitle(Text("Friends of \(userName)"), displayMode: .inline)
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var user = User(id: UUID(), isActive: true, name: "John", age: 50, company: "Apple", address: "One Way Street", about: "Lorem ipsum dolore sit etiam", registered: "", tags: ["First", "Test"], friends: [User.Friends(id: UUID(), name: "FriendTest")])
    
    static var previews: some View {
        FriendsList(friends: user.friends, userName: user.name)
    }
}
