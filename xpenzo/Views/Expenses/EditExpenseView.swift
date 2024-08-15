//
//  EditExpenseView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 04/08/24.
//

import SwiftUI
import SwiftData

struct EditExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var viewModel = EditExpenseViewModel()
    var expense: Expense?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.headline)
                TextField("Dinner for two", text: $viewModel.name)
                    .textFieldStyle(ValidatedTextFieldStyle(hasError: viewModel.invalidFields[.name] ?? false))
            }
            
            VStack(alignment: .leading) {
                Text("Amount")
                    .font(.headline)
                TextField("25.00", text: $viewModel.amountStr)
                    .textFieldStyle(
                        ValidatedTextFieldStyle(
                            hasError: viewModel.invalidFields[.amount] ?? false,
                            leadingText: Locale.current.currencySymbol
                        )
                    )
            }
            
            VStack(alignment: .leading) {
                Text("Category")
                    .font(.headline)
                
                if let category = viewModel.selectedCategory {
                    NavigationLink {
                        SelectCategory(selectedCategory: $viewModel.selectedCategory)
                    } label: {
                        CategoryRow(category: category, showRightChevron: true)
                    }
                } else {
                    HStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 34))
                            .foregroundStyle(.danger)
                        Text("You need to add at least one expenses category first.")
                            .foregroundStyle(.black.opacity(0.8))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.dangerLight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            VStack(alignment: .leading) {
                Text("Date and time")
                    .font(.headline)
                DatePicker("", selection: $viewModel.createdAt)
            }
            Spacer()

            PrimaryButton(localizedStringKey: "Save", isEnabled: viewModel.isValid) {
                save()
            }
        }
        .padding()
        .background(Color.background)
        .navigationTitle("Edit expense")
        .onAppear {
            viewModel.modelContext = modelContext
            
            if viewModel.expense == nil {
                viewModel.expense = expense
            }
            
            viewModel.loadDefaultCategory()
        }
    }
    
    private func save() {
        viewModel.save()
        dismiss()
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return NavigationStack {
        EditExpenseView()
    }
    .modelContainer(container)
}
