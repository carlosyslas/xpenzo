//
//  Expense.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 03/08/24.
//

import Foundation
import SwiftData

@Model
final class Expense {
    var name: String
    var category: Category
    var createdAt: Date
    var amount: Double
    
    init(name: String, category: Category, createdAt: Date, amount: Double) {
        self.name = name
        self.category = category
        self.createdAt = createdAt
        self.amount = amount
    }
}
