//
//  AddView.swift
//  HabitTracker
//
//  Created by Loris on 28/02/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode
    
    @State private var titleHabit = ""
    @State private var descriptionHabit = ""
    @State private var countHabit = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.white)
                        .shadow(color: .green, radius: 2, x: 0.0, y: 0.0)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.45), radius: 10, x: 0.0, y: 0.0)
                    
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.title)
                        TextField("Insert text here", text: $titleHabit)
                    }
                    .padding()
                }
                
                Divider()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.white)
                        .shadow(color: .green, radius: 2, x: 0.0, y: 0.0)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.45), radius: 10, x: 0.0, y: 0.0)
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title2)
                        TextField("Insert text here", text: $descriptionHabit)
                    }
                    .padding()
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.white)
                        .shadow(color: .green, radius: 2, x: 0.0, y: 0.0)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.45), radius: 10, x: 0.0, y: 0.0)
                    
                    VStack(alignment: .leading) {
                        Text("Count")
                            .font(.title2)
                        TextField("Insert count here", text: $countHabit)
                            .keyboardType(.decimalPad)
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        let newHabit = Habit(title: titleHabit, description: descriptionHabit, count: Int(countHabit) ?? 0)
                        user.habits.append(newHabit)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                })
                }
            }
            .padding()
            .background(Color.green.edgesIgnoringSafeArea(.all))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var user = User()
    
    static var previews: some View {
        AddView(user: user)
    }
}
