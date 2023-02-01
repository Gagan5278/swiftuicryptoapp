//
//  UIApplication+Extension.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
