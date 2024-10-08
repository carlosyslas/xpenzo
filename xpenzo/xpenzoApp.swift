//
//  xpenzoApp.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

@main
struct xpenzoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Category.self,
            Expense.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootTabsView()
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
