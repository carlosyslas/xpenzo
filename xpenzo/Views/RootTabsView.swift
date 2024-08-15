//
//  RootTabsView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

struct RootTabsView: View {
    enum Tabs {
        case expenses
        case dashbaord
        case categories
    }
    @State var tab: Tabs = Tabs.expenses
    
    var body: some View {
        TabView(selection: $tab,
                content:  {
            ExpensesListView()
                .tabItem { Label("Expenses", systemImage: "bitcoinsign.square") }.tag(Tabs.expenses)
                .toolbarBackground(Color.background, for: .tabBar)
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "chart.bar") }.tag(Tabs.dashbaord)
                .toolbarBackground(Color.background, for: .tabBar)
            CategoriesListView()
                .tabItem { Label("Categories", systemImage: "rectangle.3.group") }.tag(Tabs.categories)
                .toolbarBackground(Color.background, for: .tabBar)
        })
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return RootTabsView()
        .modelContainer(container)
}
