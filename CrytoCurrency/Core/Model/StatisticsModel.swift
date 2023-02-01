//
//  StatisticsModel.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
struct StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
    
    // MARK: - init
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}
