//
//  EditCategoryForm.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 03/08/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class EditCategoryViewModel {
    @ObservationIgnored
    var modelContext: ModelContext?
    
    enum ValidatedFields {
        case name
    }
    
    private(set) var invalidFields: [ValidatedFields: Bool] = [:]
    var category: Category? {
        didSet {
            if let category = category {
                name = category.name
                color = category.color
                icon = category.icon
            }
        }
    }
    var name: String = "" {
        didSet {
            invalidFields[.name] = !(name.count > 2)
        }
    }
    var color: CategoryColor = .color1
    var icon: CategoryIcon = .carrot
    
    var isValid: Bool {
        !(invalidFields[.name] ?? false)
    }
    
    func save() {
        if let category = category {
            category.name = name
            category.color = color
            category.icon = icon
        } else {
            let category = Category(
                name: name,
                color: color,
                icon: icon
            )
            modelContext?.insert(category)
        }
    }
}
