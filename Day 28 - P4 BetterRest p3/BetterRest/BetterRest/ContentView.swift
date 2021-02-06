//
//  ContentView.swift
//  BetterRest
//
//  Created by Loris on 06/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var idealBedtime: String {
        calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?").font(.subheadline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep").font(.subheadline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake").font(.subheadline)) {
                    Picker("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { row in
                            Text("\(row) cups")
                        }
                    }
                }
                
                Section(header: Text("Ideal Bedtime").font(.subheadline)) {
                    Text(idealBedtime)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let sleepTimeString = formatter.string(from: sleepTime)
            return "Your ideal bedtime is... " + sleepTimeString
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
