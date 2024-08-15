//
//  CategoryIconView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

struct CategoryIconView: View {
    var category: Category
    
    var body: some View {
        Image(systemName: category.icon.rawValue)
            .padding()
            .foregroundStyle(category.color.foreground)
            .background(category.color.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(category.color.foreground, lineWidth: 1)
            }
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return CategoryIconView(category: PreviewData.shared.categories[0])
        .modelContainer(container)
}
