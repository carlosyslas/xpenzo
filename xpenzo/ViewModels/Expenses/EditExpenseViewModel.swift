//
//  EditExpenseForm.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 05/08/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class EditExpenseViewModel {
    @ObservationIgnored
    var modelContext: ModelContext?
    private var firstCategory: Category?
    
    enum ValidatedFields {
        case name
        case amount
    }
    private(set) var invalidFields: [ValidatedFields: Bool] = [
        .name: false,
        .amount: false
    ]
    var expense: Expense? {
        didSet {
            guard let expense = expense else { return }
            name = expense.name
            amountStr = expense.amount.formatted()
            createdAt = expense.createdAt
            selectedCategory = expense.category
        }
    }
    var name = "" {
        didSet {
            invalidFields[.name] = !(name.count > 2)
        }
    }
    var amountStr = "" {
        didSet {
            invalidFields[.amount] = !(amount > 0)
        }
    }
    var createdAt = Date.now
    var selectedCategory: Category?

    var amount: Double {
        if let amount = Double(amountStr) {
            return amount
        }
        return .zero
    }
    
    var isValid: Bool {
        !(invalidFields[.name] ?? false) && selectedCategory != nil && !(invalidFields[.amount] ?? false)
    }
    
    func loadDefaultCategory() {
        if selectedCategory !== nil {
            return
        }
        var fetchDescriptor = FetchDescriptor<Category>(sortBy: [.init(\.name, order: .forward)])
        fetchDescriptor.fetchLimit = 1
        do {
            let categories = try modelContext?.fetch(fetchDescriptor)
            guard let categories = categories, categories.count > 0 else { return }
            selectedCategory = categories[0]
        } catch {
            print("Error fetching first cateogory: \(error)")
        }
    }
    
    func save() {
        guard let category = selectedCategory else { return }
        
        if let expense = expense {
            expense.name = name
            expense.amount = amount
            expense.category = category
            expense.createdAt = createdAt
        } else {
            let expense = Expense(
                name: name,
                category: category,
                createdAt: createdAt,
                amount: amount
            )
            
            modelContext?.insert(expense)
        }
    }
}
