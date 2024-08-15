//
//  TimeChart.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 06/08/24.
//

import SwiftUI
import Charts
import SwiftData

struct TimeChart: View {
    var categoriesAsoc: [(CategoryKey, [Expense])]
    
    var body: some View {
        Chart(categoriesAsoc.prefix(4), id: \.0.id) { group in
            ForEach(buildChartData(group.1), id: \.0) { (date, amount) in
                LineMark(
                    x: .value(
                        "Date",
                        date
                    ),
                    y: .value("Amount", amount)
                )
                .interpolationMethod(.catmullRom)
                    .symbol(by: .value("Category", group.0.name))
            }
            .foregroundStyle(by: .value("Category", group.0.name))
        }
        .frame(height: 200)
        .padding()
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8)).overlay {
            if categoriesAsoc.isEmpty {
                ContentUnavailableView(
                    "No expenses found",
                    systemImage: "chart.xyaxis.line",
                    description: Text("We weren't able to find any expenses in the selected time range.")
                )
            }
        }
    }
    
    private func buildChartData(_ expenses: [Expense]) -> [(Date, Double)] {
        aggregateAmountsByDate(
            expenses
                .map(toDateAmountPair)
        )
    }
    
    private func toDateAmountPair(_ expense: Expense) -> (Date, Double) {
        (expense.createdAt, expense.amount)
    }
    
    private func aggregateAmountsByDate(_ items: [(Date, Double)]) -> [(Date, Double)] {
        return items.reduce(into: [Date:Double]()) { partialResult, item in
            let date = item.0
            if var currentAmount = partialResult[date] {
                currentAmount += item.1
                partialResult[date] = currentAmount
            } else {
                partialResult[date] = item.1
            }
        }
        .map { (date, amount) in
            (date, amount)
        }
        .sorted(by: { item1, item2 in
            item1.0 < item2.0
        })
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return TimeChart(categoriesAsoc: PreviewData.shared.chartData)
        .padding()
        .background(Color.background)
}
