//
//  HapticManager.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/30.
//

import Foundation
import SwiftUI
class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
