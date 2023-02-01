//
//  PortfolioCoinView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/23.
//

import SwiftUI

struct PortfolioCoinView: View {
    let coinModel: CryptoModel
    var body: some View {
        VStack {
            CoinImageView(coinModel: coinModel)
                .frame(width: 70, height: 50)
            Text(coinModel.symbol.uppercased())
                .font(.headline)
            Text(coinModel.name)
                .font(.caption)
                .lineLimit(nil)
        }
    }
}

struct PortfolioCoinView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCoinView(coinModel: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
