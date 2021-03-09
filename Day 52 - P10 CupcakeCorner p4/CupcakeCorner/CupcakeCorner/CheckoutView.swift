//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Loris on 08/03/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var userOrder: UserOrder
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(userOrder.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        })
        .navigationBarTitle(Text("Check out"), displayMode: .inline)
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(userOrder.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                confirmationTitle = "Network problem"
                confirmationMessage = "It was not possbile to download the data.\nPlease check your connection."
                showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                confirmationTitle = "Thank You!"
                confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                showingConfirmation = true
            } else {
                confirmationTitle = "Ops, something went wrong..."
                confirmationMessage = "There was some problem with your order."
                showingConfirmation = true
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(userOrder: UserOrder())
    }
}
