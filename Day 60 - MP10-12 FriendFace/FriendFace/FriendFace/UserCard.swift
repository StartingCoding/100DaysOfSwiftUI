//
//  UserCard.swift
//  FriendFace
//
//  Created by Loris on 30/03/21.
//

import SwiftUI

struct UserCard: View {
    var user: User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 255 / 255, green: 193 / 255, blue: 94 / 255))
                .shadow(color: Color(red: 204 / 255, green: 88 / 255, blue: 3 / 255), radius: 5, x: 0.0, y: 0.0)
                .shadow(color: Color(red: 247 / 255, green: 176 / 255, blue: 91 / 255), radius: 25, x: 0.0, y: 0.0)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(user.name)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Image(systemName: "circle.fill")
                        .foregroundColor(user.isActive ? .green : .red)
                    Text(user.wrappedIsActive)
                        .foregroundColor(user.isActive ? .green : .red)
                }
                
                VStack(alignment: .leading) {
                    Text("Age: \(user.age)")
                    Text("Working at: \(user.company)")
                }
                
                VStack(alignment: .leading) {
                    Text("Bio")
                        .fontWeight(.bold)
                    
                    Text(user.about)
                        .truncationMode(.tail)
                }
                
                NavigationLink(destination: FriendsList(friends: user.friends, userName: user.name)) {
                    HStack {
                        Text(user.friends[0].name)
                            .foregroundColor(.primary)
                        
                        if user.friends.count > 1 {
                            Spacer()
                            
                            HStack {
                                Text("Show Friends")
                                    .lineLimit(1)
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color(red: 31 / 255, green: 19 / 255, blue: 0))
                            .foregroundColor(.white)
                            .layoutPriority(1)
                            .clipShape(Capsule())
                        }
                    }
                }
                
                Text(user.address)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
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
        }
        .padding()
    }
}

struct UserCard_Previews: PreviewProvider {
    static var user = User(id: UUID(), isActive: true, name: "John", age: 50, company: "Apple", address: "One Way Street", about: "Lorem ipsum dolore sit etiam", registered: "", tags: ["First", "Test"], friends: [User.Friends(id: UUID(), name: "FriendTest")])
    
    static var previews: some View {
        UserCard(user: user)
    }
}
