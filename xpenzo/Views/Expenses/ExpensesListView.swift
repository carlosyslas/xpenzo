//
//  ExpensesListView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI
import SwiftData

struct ExpensesListView: View {
    @Environment(\.modelContext) var modelContext
    @State var expensesList: ExpensesListViewModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expensesList?.expensesByDay ?? [], id: \.0) {
                    dateComponents,
                    expenses in
                    Section(
                        header: HStack {
                            Text(
                                (Calendar.current.date(from: dateComponents) ?? .now).formatted(date: .abbreviated, time: .omitted)
                            )
                            .padding(4)
                            .padding(.horizontal)
                            .foregroundStyle(Color.black.opacity(0.5))
                            Spacer()
                        }
                            .listRowInsets(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0
                                )
                            )
                            .background(Color.background)
                    ) {
                        ForEach(expenses) { expense in
                            NavigationLink {
                                EditExpenseView(expense: expense)
                            } label: {
                                ExpenseRow(expense: expense)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: { offsets in
                            let toDelete = offsets.compactMap { index in
                                expenses[index]
                            }
                            expensesList?.delete(expenses: toDelete)
                        })
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem {
                    NavigationLink {
                        EditExpenseView()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            })
            .listStyle(.plain)
            .background(Color.background)
            .navigationTitle("Expenses")
            .toolbarBackground(Color.background, for: .navigationBar)
            .overlay {
                if (expensesList?.isEmpty ?? true) {
                    ContentUnavailableView(
                        "No expenses found",
                        systemImage: "bitcoinsign.square",
                        description: Text("Once you add your expenses they will be displayed in this list.")
                    )
                }
            }
            .onAppear {
                expensesList = ExpensesListViewModel(modelContext: modelContext)
                expensesList?.fetch()
            }
        }
    }
}

#Preview {
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Expense.self, configurations: modelConfiguration)

    PreviewData.shared.addToModelContext(container.mainContext)
    
    return ExpensesListView()
            .modelContainer(container)
}
