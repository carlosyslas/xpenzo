//
//  ExpenseRow.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 03/08/24.
//

import SwiftUI
import SwiftData

struct ExpenseRow: View {
    var expense: Expense
    private let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var body: some View {
        HStack {
            CategoryIconView(category: expense.category)
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text("\(expense.category.name) - \(expense.createdAt.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundStyle(Color.black.opacity(0.6))
            }
            Spacer()
            Text(formatter.string(from: NSNumber(value: expense.amount)) ?? expense.amount.formatted(.currency(code: "USD")))
                .font(.callout)
                .padding(4)
                .foregroundStyle(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor)
                }
        }
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return Group {
        ExpenseRow(expense: PreviewData.shared.expenses[0])
            .modelContainer(container)
        
        ExpenseRow(expense: PreviewData.shared.expenses[1])
            .modelContainer(container)
    }
}
