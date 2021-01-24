//
//  ContentView.swift
//  UnitConverter
//
//  Created by Loris on 24/01/21.
//

import SwiftUI

struct ContentView: View {
    var inputLenghttUnits = ["Meter", "Kilometer"]
    @State private var inputLenghtSelection = 0
    
    var outputLenghttUnits = ["Feet", "Yard", "Miles"]
    @State private var outputLenghtSelection = 0
    
    @State private var input = "0"
    var output: String {
        guard var baseLine = Double(input) else { return "0" }
        
        if inputLenghtSelection != 0 {
            baseLine /= 1000
        }
        
        if outputLenghtSelection == 0 {
            baseLine *= 3.281
        } else if outputLenghtSelection == 2 {
            baseLine *= 1.094
        } else if outputLenghtSelection == 3 {
            baseLine *= 1609
        }
        
        return String(baseLine)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Insert your input")) {
                    Picker("Lenght", selection: $inputLenghtSelection) {
                        ForEach(0..<inputLenghttUnits.count) {
                            Text("\(inputLenghttUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("What you want to convert", text: $input)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Output of your choice")) {
                    Picker("Lenght", selection: $outputLenghtSelection) {
                        ForEach(0..<outputLenghttUnits.count) {
                            Text("\(outputLenghttUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Output: \(output)")
                }
            }
            .navigationBarTitle(Text("UnitConverter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
