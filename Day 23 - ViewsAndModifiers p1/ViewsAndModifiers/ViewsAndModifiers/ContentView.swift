//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Loris on 29/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, cols: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct GridStack<Content: View>: View {
    var rows: Int
    var cols: Int
    var content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack{
                    ForEach(0..<cols, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
    
    init(rows: Int, cols: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.cols = cols
        self.content = content
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
