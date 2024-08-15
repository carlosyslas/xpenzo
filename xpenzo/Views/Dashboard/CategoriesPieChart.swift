//
//  CategoriesPieChart.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 06/08/24.
//

import SwiftUI
import SwiftData
import Charts

struct CategoriesPieChart: View {
    var categoriesAsoc: [(CategoryKey, [Expense])]
    
    var body: some View {
        Chart(categoriesAsoc.prefix(4), id: \.0.id) { group in
            SectorMark(
                angle: .value(
                    "Value",
                    group.1.reduce(0, { partialResult, expense in
                        partialResult + expense.amount
                    })
                ),
                innerRadius: .ratio(0.5),
                angularInset: 2
            )
            .foregroundStyle(by: .value("Category", group.0.name))
            .cornerRadius(4)
        }
        .frame(height: 200)
        .padding()
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            if categoriesAsoc.isEmpty {
                ContentUnavailableView(
                    "No expenses found",
                    systemImage: "chart.pie",
                    description: Text("We weren't able to find any expenses in the selected time range.")
                )
            }
        }
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return CategoriesPieChart(
        categoriesAsoc: PreviewData.shared.chartData
    )
    .modelContainer(container)
}
