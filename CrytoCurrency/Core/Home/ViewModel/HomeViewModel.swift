//
//  HomeViewModel.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/10.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticsModel] = [
        StatisticsModel(title: "Market cap", value: "$2.34Bn", percentage: 1),
        StatisticsModel(title: "Market cap", value: "$3.04Bn"),
        StatisticsModel(title: "Market cap", value: "$12.04Bn"),
        StatisticsModel(title: "Market cap", value: "$43.34Bn", percentage: -5)
    ]
    @Published var allCoins: [CryptoModel] = []
    @Published var portfolioCoins: [CryptoModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sorting: Sort = .holding
    @Published var launchScreenCompleted: Bool = false

    private let networkRequest = NetworkRequest()
    private let statsNetworkRequest = NetworkRequest()
    private let portfolioService = PortfoliDataService()
    
    private var cancellablesCoin: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    enum Sort {
        case rank, rankReversed, holding, holdingReversed, price, priceReversed
    }
    
    // MARK: - init
    init() {
        addSubscribers()
        fetchCoinModel()
    }
    
    // MARK: - Fetch coin model
    private func fetchCoinModel() {
        networkRequest.fetchRequest(codable: [CryptoModel].self, urlString: AppConstants.coinURL)
        fetchMarketModel()
    }
    
    // MARK: - Fetch Market model
    private func fetchMarketModel() {
        statsNetworkRequest.fetchRequest(codable: MarketDataModel.self, urlString: AppConstants.marketURL)
    }
    
    private func addSubscribers() {
        // 1. Coin subscription
        $searchText
            .combineLatest(networkRequest.$responseRecieved, $sorting)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.launchScreenCompleted = !returnedCoins.isEmpty
            }
            .store(in: &cancellables)
        
        // 2. Market Model subscription
        statsNetworkRequest
            .$responseRecieved
            .combineLatest($portfolioCoins)
            .map(updateStatisticsModel)
            .sink { [weak self] statsModel in
                self?.statistics = statsModel
            }
            .store(in: &cancellables)
        
        // 3. Portfolio coins
        $allCoins.combineLatest(portfolioService.$savedEntities)
            .map(updatePortfolio)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortCoinsOnHolding(coins: coins, sort: self.sorting)
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        isLoading = true
        HapticManager.notification(type: .success)
        fetchCoinModel()
    }
    
    private func updatePortfolio(coinModels: [CryptoModel],portfolioEntity: [PortfolioEntity]) -> [CryptoModel] {
        coinModels.compactMap { coin in
            guard let entity = portfolioEntity.first(where: {$0.coinID == coin.id}) else { return nil }
            return coin.updateHolding(amount: entity.amount)
        }
    }
    
    private func updateStatisticsModel(codableModel: Codable?, portfolio: [CryptoModel])  -> [StatisticsModel] {
        if let model = codableModel as? MarketDataModel {
            var statsModel: [StatisticsModel] = []
            statsModel.append(StatisticsModel(title: "Market cap", value: model.data.marketCap, percentage: model.data.marketCapChangePercentage24HUsd))
            statsModel.append(StatisticsModel(title: "24h Volume", value: model.data.volume))
            statsModel.append(StatisticsModel(title: "BTC Dominance", value: model.data.btcDominance))
            
            let currentPortfolioValue = portfolio
                .map ({ $0.currentHoldingValue})
                .reduce(0, +)
            
            let previousValue = portfolio
                .map { coin -> Double in
                    let currentValue = coin.currentHoldingValue
                    let percentageChange = (coin.priceChangePercentage24H ?? 0.0) / 100
                    let previousValue = currentValue / ( 1 + percentageChange )
                    return previousValue
                }
                .reduce(0, +)
            
            let percentageChnage = (currentPortfolioValue - previousValue) / previousValue
            
            statsModel.append(StatisticsModel(title: "Portfolio Value", value: currentPortfolioValue.asTwoDigitNumberString, percentage: percentageChnage))

            return statsModel
        }
        return []
    }
    
    private func filterAndSortCoins(with text: String, recievedModels: Codable?, sort: Sort) -> [CryptoModel]  {
        if let coins = recievedModels as? [CryptoModel] {
          var filteredCoins = filterCoins(with: text, coins: coins)
            sortCoins(coins: &filteredCoins, sort: sort)
            return filteredCoins
        } else {
            return []
        }
    }
    
    private func sortCoins(coins: inout [CryptoModel], sort: Sort) {
        switch sort {
        case .rank, .holding:
             coins.sort{$0.rank > $1.rank}
        case .price, .holdingReversed:
            coins.sort{$0.currentPrice > $1.currentPrice}
        case .rankReversed:
            coins.sort{$0.rank < $1.rank}
        case .priceReversed:
            coins.sort{$0.currentPrice < $1.currentPrice}
        }
    }
    
    private func sortCoinsOnHolding(coins: [CryptoModel], sort: Sort) -> [CryptoModel] {
        switch sort {
        case .holding:
            return coins.sorted{$0.currentHoldingValue > $1.currentHoldingValue}
        case .holdingReversed:
            return coins.sorted{$0.currentHoldingValue < $1.currentHoldingValue}
        default :
            return coins
        }
    }

    
    private func filterCoins(with text: String, coins: [CryptoModel]) -> [CryptoModel] {
            if text.isEmpty {
                return coins
            }
            let lowerText = text.lowercased()
            return coins.filter { model in
                model.name.lowercased().contains(lowerText) ||  model.symbol.contains(lowerText) ||  model.id.contains(lowerText)
            }
    }
    
    func updatePortfolio(coin: CryptoModel, amount: Double) {
        portfolioService.updateEntity(amount: amount, coin: coin)
    }
}
