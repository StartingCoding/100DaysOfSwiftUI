//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Loris on 08/03/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var userOrder: UserOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $userOrder.order.name)
                TextField("Street Address", text: $userOrder.order.streetAddress)
                TextField("City", text: $userOrder.order.city)
                TextField("Zip", text: $userOrder.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(userOrder: userOrder)) {
                    Text("Check out")
                }
            }
            .disabled(userOrder.order.hasValidData == false)
        }
        .navigationBarTitle(Text("Delivery details"), displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(userOrder: UserOrder())
    }
}
