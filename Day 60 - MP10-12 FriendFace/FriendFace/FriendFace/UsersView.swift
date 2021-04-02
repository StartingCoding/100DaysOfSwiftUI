//
//  UserView.swift
//  FriendFace
//
//  Created by Loris on 30/03/21.
//

import SwiftUI

struct UsersView: View {
    @Binding var users: [User]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(users) { user in
                UserCard(user: user)
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(users: Binding.constant(Users().users))
    }
}
