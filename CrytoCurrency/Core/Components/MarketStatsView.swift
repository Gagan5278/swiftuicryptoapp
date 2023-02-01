//
//  MarketStatsView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import SwiftUI

struct MarketStatsView: View {
    let statsModel: StatisticsModel
    var body: some View {
        VStack {
            Text(statsModel.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(statsModel.value)
                .font(.headline)
                .minimumScaleFactor(0.7)
                .lineLimit(2)
                .foregroundColor(Color.theme.accent)
                .padding(.horizontal)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                Text((statsModel.percentage ?? 0).asNumberPercenrageString)
            }
            .foregroundColor((statsModel.percentage ?? 0) > 0 ? Color.green : Color.red)
            .opacity((statsModel.percentage ?? 0)  != 0 ? 1 : 0)
        }
        .padding()
    }
}

struct MarketStatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MarketStatsView(statsModel: dev.stat1)
                .previewLayout(.sizeThatFits)
            MarketStatsView(statsModel: dev.stat2)
                .previewLayout(.sizeThatFits)
            MarketStatsView(statsModel: dev.stat3)
                .previewLayout(.sizeThatFits)
        }

    }
}
