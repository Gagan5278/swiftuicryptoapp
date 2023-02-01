//
//  Date+Extension.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/02/01.
//

import Foundation

extension Date {
    func getHumanReadableDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
