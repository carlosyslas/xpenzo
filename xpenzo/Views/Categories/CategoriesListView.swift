//
//  CategoriesListView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

struct CategoriesListView: View {
    @Environment(\.modelContext) private var modelContext
    @State var categoriesList: CategoriesListViewModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categoriesList?.categories ?? []) { category in
                    NavigationLink {
                        EditCategoryView(category: category)
                    } label: {
                        CategoryRow(category: category)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSpacing(0)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: delete)
            }
            .toolbar(content: {
                ToolbarItem {
                    NavigationLink {
                        EditCategoryView()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            })
            .listStyle(.plain)
            .background(Color.background)
            .navigationTitle("Categories")
            .toolbarBackground(Color.background, for: .navigationBar)
            .overlay {
                if (categoriesList?.categories.isEmpty ?? true) {
                    ContentUnavailableView(
                        "No categories found",
                        systemImage: "rectangle.3.group",
                        description: Text("Expenses belong to a category. You will see a list of your expense categories here.")
                    )
                }
            }
            .onAppear {
                categoriesList = CategoriesListViewModel(modelContext: modelContext)
                categoriesList?.fetch()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let categories = offsets.compactMap { index in
            categoriesList?.categories[index]
        }
        categoriesList?.delete(categories: categories)
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return CategoriesListView()
        .modelContainer(container)
}
