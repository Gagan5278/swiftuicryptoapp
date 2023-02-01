//
//  HomeMarketStatsView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import SwiftUI

struct HomeMarketStatsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var shouldShowHolding: Bool
    
    var body: some View {
        HStack {
            ForEach(homeViewModel.statistics) { stat in
                MarketStatsView(statsModel: stat)
                    .frame(width: UIScreen.main.bounds.width/3, alignment: .leading)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: shouldShowHolding ? .trailing : .leading)
    }
}

struct HomeMarketStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMarketStatsView(shouldShowHolding: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
