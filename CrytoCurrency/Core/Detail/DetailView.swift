//
//  CoinDetailView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/31.
//

import SwiftUI

struct CoinDetailView: View {
    @Binding var coin: CryptoModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var viewModel: CoinDetialViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 20.0
    @State var showDetailDescription: Bool = false
    
    init(coin: CryptoModel) {
        _viewModel = StateObject(wrappedValue: CoinDetialViewModel(coin: coin))
        print("In Detail coin : \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ChartView(coin: viewModel.selectedCoin)
                    .padding(.vertical, 10)
                if let description = viewModel.coinDescription, !description.isEmpty {
                    ZStack {
                        VStack(alignment: .leading) {
                            Text(description)
                                .lineLimit(showDetailDescription ?  nil : 3)
                                .font(.callout)
                            Button {
                                withAnimation(.linear) {
                                    showDetailDescription.toggle()
                                }
                            } label: {
                                Text(showDetailDescription ? "Less": "Show more")
                                    .font(.caption)
                                    .foregroundColor(Color.theme.accent)
                            }
                        }
                    }
                    .padding(5)
                }
                overViewText
                Divider()
                overViewGrid
                addtionalText
                additionalGrid
                Divider()
                coinLinks
            }
        }
        .navigationTitle(viewModel.coinName)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarItem
            }
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var overViewText: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overViewStatsModel) { stat in
                    MarketStatsView(statsModel: stat)
                }
            })
    }
    
    private var addtionalText: some View {
        Text("Additional details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: nil, pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStatsModel) { stat in
                    MarketStatsView(statsModel: stat)
                }
            })
    }
    
    private var navigationBarItem: some View {
        HStack {
            Text(viewModel.selectedCoin.symbol.uppercased())
            CoinImageView(coinModel: viewModel.selectedCoin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var coinLinks: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 10) {
                if let homePageURL = viewModel.homepageURL, let url = URL(string: homePageURL) {
                    Link("Home Page", destination: url)
                        .foregroundColor(.blue)
                }
                if let homePageURL = viewModel.subredditURL, let url = URL(string: homePageURL) {
                    Link("Reddit Page", destination: url)
                        .foregroundColor(.blue)
                }
            }
            .font(.footnote)
            .padding()
        }

    }
}
