//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Baptiste Cadoux on 10/09/2021.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
