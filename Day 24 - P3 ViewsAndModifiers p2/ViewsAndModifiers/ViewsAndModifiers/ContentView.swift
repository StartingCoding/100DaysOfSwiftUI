//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Loris on 30/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(stops:
                                                    [Gradient.Stop(color: Color.white, location: 0.5),
                                                     Gradient.Stop(color: Color.blue, location: 0.75),
                                                     Gradient.Stop(color: Color.white, location: 1)]),
                               center: .center,
                               startRadius: 40,
                               endRadius: 190)
                
                Text("Hello, SwiftUI!")
                    .makeLargeBlueTitle()
                    .navigationBarTitle(Text("ViewsAndModifiers"))
            }
        }
    }
}

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func makeLargeBlueTitle() -> some View {
        self.modifier(LargeBlueTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
