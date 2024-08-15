//
//  DashboardView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData
import Charts

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @State var selectedRange = TimeRange.today
    private var filteredExpenses: [Expense] {
        expenses.filter { expense in
            selectedRange.range.contains(expense.createdAt)
        }
    }
    
    private var groupedExpenses: [CategoryKey: [Expense]] {
        return filteredExpenses.reduce(into: [:]) { partialResult, expense in
            let key = CategoryKey(id: expense.category.id, name: expense.category.name)
            if var group = partialResult[key] {
                group.append(expense)
                partialResult[key] = group
            } else {
                partialResult[key] = [expense]
            }
        }
    }
    private var sortedGroups: [(CategoryKey, [Expense])] {
        groupedExpenses.enumerated().map { ($0.element.key, $0.element.value) }
            .sorted { group1, group2 in
                let total1 = group1.1.reduce(0) { partialResult, expense in
                    partialResult + expense.amount
                }
                let total2 = group2.1.reduce(0) { partialResult, expense in
                    partialResult + expense.amount
                }
                return total1 > total2
            }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $selectedRange) {
                        ForEach(TimeRange.allCases, id: \.label) { range in
                            Text(range.label).tag(range)
                        }
                    } label: {
                        Text("Prueba")
                    }
                    .pickerStyle(.segmented)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("By category")
                            .font(.title2)
                        CategoriesPieChart(categoriesAsoc: sortedGroups)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("By time")
                            .font(.title2)
                        TimeChart(categoriesAsoc: sortedGroups)
                    }
                }
                .padding()
            }
            .background(Color.background)
            .navigationTitle("Dashboard")
            .toolbarBackground(Color.background, for: .navigationBar)
        }
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return DashboardView()
        .modelContainer(container)
}
