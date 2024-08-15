//
//  ExpensesListViewModel.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 15/08/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class ExpensesListViewModel {
    @ObservationIgnored
    private var modelContext: ModelContext
    private(set) var expenses: [Expense] = []
    
    private var groupedExpenses: [DateComponents: [Expense]] {
        return expenses.reduce(into: [:]) { partialResult, expense in
            let key = Calendar.current.dateComponents([.year, .month, .day], from: expense.createdAt)
            if var group = partialResult[key] {
                group.append(expense)
                partialResult[key] = group
            } else {
                partialResult[key] = [expense]
            }
        }
    }
    var expensesByDay: [(DateComponents, [Expense])] {
        groupedExpenses.enumerated().map { group in return (group.element.key, group.element.value) }
            .sorted { (group1, group2) in
                let date1 = Calendar.current.date(from: group1.0) ?? .now
                let date2 = Calendar.current.date(from: group2.0) ?? .now
                return date1 > date2
            }
    }
    
    var isEmpty: Bool {
        expenses.isEmpty
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetch() {
        let fetchDescriptor = FetchDescriptor<Expense>(
            sortBy: [.init(\.createdAt, order: .reverse)]
        )
        
        do {
            expenses = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching expenses: \(error)")
        }
    }
    
    func delete(expenses: [Expense]) {
        expenses.forEach { expense in
            modelContext.delete(expense)
        }
        fetch()
    }
}
