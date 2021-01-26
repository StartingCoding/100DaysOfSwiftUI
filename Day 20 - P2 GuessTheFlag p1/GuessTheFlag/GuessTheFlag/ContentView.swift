//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Loris on 25/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center).edgesIgnoringSafeArea(.all)
            
            Button(action: {
                showingAlert = true
            }, label: {
                HStack(spacing: 10) {
                    Image(systemName: "eye.fill")
                        .renderingMode(.original)
                    Text("Show Alert")
                }
                .font(.title)
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Hello SwiftUI"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
