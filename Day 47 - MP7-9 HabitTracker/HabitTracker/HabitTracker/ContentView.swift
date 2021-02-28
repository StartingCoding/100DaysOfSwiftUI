//
//  ContentView.swift
//  HabitTracker
//
//  Created by Loris on 28/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var user = User()
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            HabitsList(habits: $user.habits)
                .navigationBarTitle(Text("Habit Tracker"))
                .navigationBarItems(
                    leading:
                        EditButton()
                        .foregroundColor(.green),
                    trailing:
                        Button(action: {
                            isShowingAddView = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.green)
                        })
                )
                .sheet(isPresented: $isShowingAddView) {
                    AddView(user: user)
                }
        }
    }
}


struct HabitsList: View {
    @Binding var habits: [Habit]
    
    var body: some View {
        if habits.isEmpty {
            Text("You are not tracking any habit.\nPlease add one now!")
        } else {
            List {
                ForEach(habits) { habit in
                    NavigationLink(destination: DetailView(habit: habit, habits: $habits)) {
                        HabitsListRow(habit: habit)
                            .padding(.top)
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
}


struct HabitsListRow: View {
    var habit: Habit
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.45), radius: 10, x: 0.0, y: 0.0)
            
            VStack {
                HStack {
                    Text(habit.title)
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Count:")
                    
                    Spacer()
                    
                    Text("\(habit.count)")
                }
                .padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
