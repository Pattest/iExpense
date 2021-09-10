//
//  AddView.swift
//  iExpense
//
//  Created by Baptiste Cadoux on 10/09/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    @State private var wrongAmount = false

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                VStack {
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                    if wrongAmount {
                        Text("Amount must be an integer")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name,
                                           type: self.type,
                                           amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.wrongAmount = true
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
