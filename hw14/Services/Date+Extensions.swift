//
//  Date+Extensions.swift
//  hw14
//
//  Created by Chernousova Maria on 06.11.2021.
//

import Foundation

extension Date {
    func formatted(with dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}
