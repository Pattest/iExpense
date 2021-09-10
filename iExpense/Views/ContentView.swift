//
//  ContentView.swift
//  iExpense
//
//  Created by Baptiste Cadoux on 10/09/2021.
//

import SwiftUI

struct ContentView: View {

    @State private var showingAddExpense = false

    @ObservedObject var expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .foregroundColor(.gray)

                            Spacer()
                            Text("$\(item.amount)")
                                .foregroundColor(getTextColor(for: item.amount))
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    })
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }

    func getTextColor(for amount: Int) -> Color {
        if amount >= 100 {
            return Color.red
        } else if amount >= 10 {
            return Color.orange
        }
        return Color.green
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
