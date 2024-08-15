//
//  PreviewData.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 06/08/24.
//

import SwiftData

class PreviewData {
    var categories: [Category] = [
        Category(name: "Food", color: .color1, icon: .carrot),
        Category(name: "Stationery", color: .color2, icon: .docPlainText),
        Category(name: "Travel", color: .color3, icon: .suitcaseRolling),
        Category(name: "Car", color: .color3, icon: .car),
    ]
    lazy var expenses: [Expense] = {
        return [
            Expense(
                name: "Sandwich",
                category: categories[0],
                createdAt: .distantPast,
                amount: 234.2
            ),
            Expense(
                name: "Sandwich",
                category: categories[1],
                createdAt: .now,
                amount: 234.2
            ),
            Expense(
                name: "Sandwich",
                category: categories[2],
                createdAt: .now,
                amount: 134.2
            ),
            Expense(
                name: "Sandwich",
                category: categories[3],
                createdAt: .distantPast.addingTimeInterval(500),
                amount: 124.2
            ),
            Expense(
                name: "Sandwich",
                category: categories[1],
                createdAt: .distantFuture,
                amount: 324.2
            ),
        ]
    }()
    lazy var chartData: [(CategoryKey, [Expense])] = {
        let cat1 = categories[0]
        let cat2 = categories[1]
        let cat3 = categories[2]
        let cat4 = categories[3]
        
        let exp1 = expenses[0]
        let exp2 = expenses[1]
        let exp3 = expenses[2]
        let exp4 = expenses[3]
        let exp5 = expenses[4]
        
        return  [
            (.init(id: cat1.id, name: cat1.name), [exp1, exp3]),
            (.init(id: cat2.id, name: cat2.name), [exp2]),
            (.init(id: cat3.id, name: cat3.name),[exp4]),
            (.init(id: cat4.id, name: cat4.name),[exp5]),
        ]
    }()
    
    func addToModelContext(_ context: ModelContext) {
        for category in categories {
            context.insert(category)
        }
        
        for expense in expenses {
            context.insert(expense)
        }
    }

    static let shared = PreviewData()
}
