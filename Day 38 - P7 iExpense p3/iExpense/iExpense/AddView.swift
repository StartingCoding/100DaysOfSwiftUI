//
//  AddView.swift
//  iExpense
//
//  Created by Loris on 16/02/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var amount = ""
    @State private var type = "Personal"
    
    static let types = ["Business", "Personal"]
    
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                TextField("Expense amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if let actualAmount = Int(amount) {
                        let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                        expenses.items.append(item)
                        
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        alertMessage = "\(amount) is not a number."
                        showingAlert = true
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Wrong Amount!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
