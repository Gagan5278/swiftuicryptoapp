//
//  CoinImageView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import SwiftUI
struct CoinImageView: View {
    @StateObject private var coinImageViewModel: CoinImageViewModel
    
    // MARK: - init
    init(coinModel: CryptoModel) {
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(model: coinModel))
    }
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if coinImageViewModel.isLoadingImage {
                ProgressView()
            } else {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coinModel: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
