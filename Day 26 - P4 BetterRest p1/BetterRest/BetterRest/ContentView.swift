//
//  ContentView.swift
//  BetterRest
//
//  Created by Loris on 01/02/21.
//

// Calendar can make Date from DateComponents and DateComponenets from Date

// var components = DateComponenets()
// var componenets.hour = 8
// var componenets.minute = 0
// let dateFromDateComponents = Calendar.current.date(from: components) ?? Date()

// let dateComponents = Calendar.current.dateComponents(from: Date())
// let hour = dateComponents.hour ?? 0
// let minute = dateComponents.minute ?? 0

// DateFormatter can format Date into String
// let formatter = DateFormatter()
// formatter.timeStyle = .short
// let dateFormattedIntoString = formatter.string(from: Date())

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Hours of sleep")) {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
            }
            
            Section(header: Text("Wake up")) {
                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
                    .labelsHidden()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
