//
//  TimeRange.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 05/08/24.
//

import Foundation

enum TimeRange: CaseIterable {
    case today
    case thisMonth
    case thisYear
    
    var label: String {
        switch self {
        case .today:
            "Today"
        case .thisMonth:
            "This month"
        case .thisYear:
            "This year"
        }
    }
    
    var range: Range<Date> {
        switch self {
        case .today:
            let start = startOfDay(.now)
            return start..<add(start, unit: .day, amount: 1)
        case .thisMonth:
            let start = startOfMonth(.now)
            return start..<add(start, unit: .month, amount: 1)
        case .thisYear:
            let start = startOfYear(.now)
            return start..<add(start, unit: .year, amount: 1)
        }
    }
    
    private func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
    
    private func add(_ date: Date, unit: Calendar.Component, amount: Int) -> Date {
        return Calendar.current.date(byAdding: unit, value: amount, to: date) ?? date
    }
    
    private func startOfMonth(_ date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        
        return Calendar.current.date(from: components) ?? date
    }
    
    private func startOfYear(_ date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year], from: date)
        
        return Calendar.current.date(from: components) ?? date
    }
}
