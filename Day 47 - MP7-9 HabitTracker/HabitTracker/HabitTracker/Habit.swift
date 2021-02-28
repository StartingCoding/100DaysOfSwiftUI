//
//  Habit.swift
//  HabitTracker
//
//  Created by Loris on 28/02/21.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var count: Int
}
