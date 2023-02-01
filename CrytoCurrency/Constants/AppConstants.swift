//
//  AppConstants.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/10.
//

import Foundation
struct AppConstants {
    static let baseURL = "https://api.coingecko.com/"
    static let coinURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    static let marketURL = "https://api.coingecko.com/api/v3/global"
}
