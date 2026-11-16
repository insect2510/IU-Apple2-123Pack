//
//  DateFormater.swift
//  123Pack
//
//  Created by Oliver Hartmann on 15.11.26.
//

import Foundation

// MARK: - Date Formatter

final class AppDateFormatter {

    static let shared = AppDateFormatter()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "de_DE")
    }

    func format(_ date: Date) -> String {
        return formatter.string(from: date)
    }
    
}
