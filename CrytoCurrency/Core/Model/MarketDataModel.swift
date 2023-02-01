//
//  MarketDataModel.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
struct MarketDataModel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key.lowercased() == "usd"}) {
            return "\(item.value.asNumberString)"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key.lowercased() == "usd"}) {
            return "\(item.value.asNumberString)"
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: {$0.key.lowercased() == "btc"}) {
            return "\(item.value.asNumberPercenrageString)"
        }
        return ""
    }
}
