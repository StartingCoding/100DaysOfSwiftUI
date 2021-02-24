//
//  ContentView.swift
//  Drawing
//
//  Created by Loris on 24/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amonthThickness: CGFloat = 10
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Arrow()
                .stroke(style: StrokeStyle(lineWidth: amonthThickness, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            
            Divider()
            
            Text("Thickness amount: \(amonthThickness, specifier: "%.2f")")
            Slider(value: $amonthThickness, in: 10...30)
                .padding()
            
            Divider()
            
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 200, height: 200)
            
            Text("Color code: \(colorCycle, specifier: "%.2f")")
            Slider(value: $colorCycle)
                .padding()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var step = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<step) { value in
                Rectangle()
                    .inset(by: CGFloat(amount))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 1), color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(amount) / Double(step) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Creating base
        let base: [CGPoint] = [
            CGPoint(x: (rect.maxX / 6) * 2, y: rect.maxY / 3),
            CGPoint(x: (rect.maxX / 6) * 2, y: rect.maxY),
            CGPoint(x: (rect.maxX / 6) * 4, y: rect.maxY),
            CGPoint(x: (rect.maxX / 6) * 4, y: rect.maxY / 3)
        ]
        path.addLines(base)
        
        // Creating direction
        let triangle: [CGPoint]  = [
            CGPoint(x: (rect.maxX / 6) * 4, y: rect.maxY / 3),
            CGPoint(x: (rect.maxX / 6) * 5, y: rect.maxY / 3),
            CGPoint(x: rect.maxX / 2, y: 0),
            CGPoint(x: rect.maxX / 6, y: rect.maxY / 3),
            CGPoint(x: (rect.maxX / 6) * 2, y: rect.maxY / 3)
        ]
        path.addLines(triangle)
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
