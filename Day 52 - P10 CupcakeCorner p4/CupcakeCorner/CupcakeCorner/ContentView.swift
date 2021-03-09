//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Loris on 08/03/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userOrder = UserOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $userOrder.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $userOrder.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(userOrder.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $userOrder.order.specialRequestEnabled.animation())  {
                        Text("Any special requests?")
                    }
                    
                    if userOrder.order.specialRequestEnabled {
                        Toggle(isOn: $userOrder.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $userOrder.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(userOrder: userOrder)) {
                        Text("Delivery details")
                    }
                }
            }
        }
        .navigationBarTitle(Text("Cupcake Corner"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
