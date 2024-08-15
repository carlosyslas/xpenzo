//
//  SelectCategory.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 05/08/24.
//

import SwiftUI
import SwiftData

struct SelectCategory: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Category.name) var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(categories) { category in
            CategoryRow(category: category, isSelected: selectedCategory == category)
                .onTapGesture {
                    selectedCategory = category
                    dismiss()
                }
        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationTitle("Expense category")
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    @State var selected: Category? = PreviewData.shared.categories.first
    
    return NavigationStack {
        SelectCategory(selectedCategory: $selected)
            .modelContainer(container)
    }
}
