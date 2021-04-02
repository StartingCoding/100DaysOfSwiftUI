//
//  DetailFriend.swift
//  FriendFace
//
//  Created by Loris on 01/04/21.
//

import SwiftUI

struct DetailFriend: View {
    @EnvironmentObject var friends: Users
    var friendName: String
    
    var friendUser: User {
        friends.users.first(where: { $0.name == friendName }) ?? User(id: UUID(), isActive: true, name: "John", age: 50, company: "Apple", address: "One Way Street", about: "Lorem ipsum dolore sit etiam", registered: "", tags: ["First", "Test"], friends: [User.Friends(id: UUID(), name: "FriendTest")])
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Age: \(friendUser.age)")
                    Text("Working at: \(friendUser.company)")
                }
                
                VStack(alignment: .leading) {
                    Text("Bio")
                        .fontWeight(.bold)
                    
                    Text(friendUser.about)
                }
                
                Text(friendUser.address)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(friendUser.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding()
                                .background(Color(red: 247 / 255, green: 147 / 255, blue: 76 / 255))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 31 / 255, green: 19 / 255, blue: 0))
                    .shadow(color: Color(red: 255 / 255, green: 193 / 255, blue: 94 / 255), radius: 5, x: 0.0, y: 0.0)
                    .shadow(color: Color(red: 247 / 255, green: 176 / 255, blue: 91 / 255), radius: 25, x: 0.0, y: 0.0)
            )
            .foregroundColor(.white)
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(friendUser.name), displayMode: .large)
    }
}

struct DetailFriend_Previews: PreviewProvider {
    static var users = Users()
    
    static var previews: some View {
        DetailFriend(friendName: User.Friends(id: UUID(), name: "John").name)
    }
}
