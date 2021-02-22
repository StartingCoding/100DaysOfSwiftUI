//
//  ContentView.swift
//  Drawing
//
//  Created by Loris on 22/02/21.
//

import SwiftUI

// MARK: Metal with DrawingGroup
struct ContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCricle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ColorCyclingCricle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(amount))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 1), color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


// MARK: Border made by ImagePaint
struct ImagePaintView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("Hello World")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("example"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 0.5), scale: 0.2), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("example"), scale: 0.2), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}


// MARK: Flower built with CGAffineTransform
struct FlowerView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
//                .stroke(Color.red, lineWidth: 1)
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding([.horizontal])
        }
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()
        
        // Count from 0 up to pi * 2 (pi * 2 in radians == 360 in degrees), moving up pi / 8 (180 / 8 degrees) each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of the loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
        }
        
        // Now send the main path back
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
