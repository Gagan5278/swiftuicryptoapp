//
//  Double+Extension.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/09.
//

import Foundation
extension Double {
    /// Convert number to minimum 2 digit and max 6 digit
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var priceToSixDigit: NumberFormatter  {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    var asSixDigitNumberString: String {
        priceToSixDigit.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
    /// Convert number to minimum 2 digit and max 6 digit
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var convertToTwoDigit: NumberFormatter  {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var asTwoDigitNumberString: String {
        convertToTwoDigit.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
    var asNumberString: String {
        String(format: "%.2f", self)
    }
    
    var asNumberPercenrageString: String {
        asNumberString + "%"
    }

    func formatNumber() -> String {
        let suffix = ["", "K", "M", "B", "T", "P", "E"]
       var index = 0
       var value = self
       while((value / 1000) >= 1){
           value = value / 1000
           index += 1
       }
       return String(format: "%.1f%@", value, suffix[index])
    }
}
