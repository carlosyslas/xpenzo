//
//  CategoriesListViewModel.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 15/08/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class CategoriesListViewModel {
    @ObservationIgnored
    private var modelContext: ModelContext
    private(set) var categories: [Category] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetch() {
        var fetchDescriptor = FetchDescriptor<Category>()
        fetchDescriptor.sortBy = [.init(\.name)]
        
        do {
            categories = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching categories: \(error)")
        }
    }
    
    func delete(categories: [Category]) {
        categories.forEach { category in
            modelContext.delete(category)
        }
        fetch()
    }
}
