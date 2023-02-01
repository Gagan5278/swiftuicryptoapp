//
//  CoinRowView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/09.
//

import SwiftUI

struct CoinRowView: View {
    @Binding var shouldShowHolding: Bool
    let coinModel: CryptoModel
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if (shouldShowHolding) {
                middleColumn
                Spacer()
            }
            rightColumn
        }
        .font(.subheadline)
        .background(Color.theme.background.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(shouldShowHolding: .constant(true), coinModel: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinRowView(shouldShowHolding: .constant(false), coinModel: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }

    }
}

extension CoinRowView {
    var leftColumn: some View {
        Group {
            Text("\(coinModel.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            CoinImageView(coinModel: coinModel)
                .frame(width: 30, height: 30)
            Text(coinModel.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    var middleColumn: some View {
        VStack(alignment: .trailing) {
            Text(coinModel.currentHoldingValue.asTwoDigitNumberString)
            Text((coinModel.currentHolding ?? 0.0).asNumberString)
        }
        .foregroundColor(Color.theme.accent)
    }
    
    var rightColumn: some View {
        VStack(alignment:.trailing) {
            Text(coinModel.currentPrice.asSixDigitNumberString)
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coinModel.priceChangePercentage24HInCurrency ?? 0.0).asNumberPercenrageString)
                .foregroundColor((coinModel.priceChangePercentage24HInCurrency ?? 0) > 0 ? Color.green : Color.red)
        }
        .frame(width: UIScreen.main.bounds.width/3, alignment: .trailing)
    }
}
