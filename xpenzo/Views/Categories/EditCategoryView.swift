//
//  EditCategoryView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = EditCategoryViewModel()
    
    init(category: Category? = nil) {
        viewModel.category = category
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(ValidatedTextFieldStyle(hasError: viewModel.invalidFields[.name] ?? false))
                }
                VStack(alignment: .leading) {
                    Text("Color")
                        .font(.headline)
                    ColorSelectorView(selectedColor: $viewModel.color)
                }
                VStack(alignment: .leading) {
                    Text("Icon")
                        .font(.headline)
                    IconSelectorView(selectedIcon: $viewModel.icon, color: viewModel.color)
                }
            }
            .padding()
            
            PrimaryButton(localizedStringKey: "Save", isEnabled: viewModel.isValid) {
                save()
            }
            .padding(.horizontal)
        }
        .background(Color.background)
        .navigationTitle(viewModel.category == nil ? "Add category" : "Edit category")
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
    
    private func save() {
        viewModel.save()
        dismiss()
    }
}

#Preview {
    EditCategoryView()
}
