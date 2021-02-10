//
//  ContentView.swift
//  Animations
//
//  Created by Loris on 10/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 4)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1.0, y: 0.0, z: 0.0)
        )
    }
}

struct ExplicitAnimationOnBinding: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct ImplicitAnimation: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            animationAmount = 2
        }
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 0.3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
