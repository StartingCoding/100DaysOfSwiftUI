//
//  DetailView.swift
//  HabitTracker
//
//  Created by Loris on 28/02/21.
//

import SwiftUI

struct DetailView: View {
    @State var habit: Habit
    @Binding var habits: [Habit]
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(habit.title)
                    .font(.title)
                    .padding()
                
                Divider()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.white)
                        .shadow(color: .green, radius: 2, x: 0.0, y: 0.0)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.45), radius: 10, x: 0.0, y: 0.0)
                    
                    Text(habit.description)
                        .font(.title2)
                        .padding()
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Button(action: {
                        habit.count -= 1
                        
                        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
                        habits[index].count = habit.count
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.35), radius: 8, x: 0.0, y: 0.0)
                    })
                    
                    Divider()
                    
                    Text("\(habit.count)")
                        .font(.title2)
                        .padding()
                    
                    Divider()
                    
                    Button(action: {
                        habit.count += 1
                        
                        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
                        habits[index].count = habit.count
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(color: .green, radius: 2, x: 0.0, y: 0.0)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.75), radius: 8, x: 0.0, y: 0.0)
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habit: Habit(title: "Test", description: "Test", count: 1), habits: Binding.constant([Habit(title: "Test", description: "Test", count: 1)]))
    }
}
