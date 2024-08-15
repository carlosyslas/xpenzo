//
//  CategoryRow.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

struct CategoryRow: View {
    var category: Category
    var showRightChevron: Bool?
    var isSelected: Bool?
    
    var body: some View {
        HStack(spacing: 8) {
            CategoryIconView(category: category)
            Text(category.name)
                .font(.title3)
                .foregroundStyle(.black)
            Spacer()
            if let showRightChevron = showRightChevron, showRightChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
            }
            if let isSelected = isSelected, isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.accent)
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return CategoryRow(category: PreviewData.shared.categories[0])
        .modelContainer(container)
}


