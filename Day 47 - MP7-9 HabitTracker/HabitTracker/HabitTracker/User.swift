//
//  User.swift
//  HabitTracker
//
//  Created by Loris on 28/02/21.
//

import Foundation

class User: ObservableObject {
    @Published var habits: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encodedData = try? encoder.encode(habits) {
                UserDefaults.standard.set(encodedData, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode([Habit].self, from: savedData) {
                self.habits = decodedData
                return
            }
        }
        
        habits = []
    }
    
    func addHabit(_ newHabit: Habit) {
        habits.append(newHabit)
    }
}
