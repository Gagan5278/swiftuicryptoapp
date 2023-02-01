//
//  CoinDetialViewModel.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/31.
//

import Foundation
import Combine

class CoinDetialViewModel: ObservableObject {
    private let coinDetailService: NetworkRequest
    @Published var selectedCoin: CryptoModel
    @Published var overViewStatsModel: [StatisticsModel] = []
    @Published var additionalStatsModel: [StatisticsModel] = []
    @Published var coinDescription: String?
    @Published var homepageURL: String?
    @Published var subredditURL: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CryptoModel) {
        selectedCoin = coin
        self.coinDetailService = NetworkRequest()
        addSubscribers()
        getCoinDetail(for: coin)
    }
    
    // MARK: - get coin detail
    private func getCoinDetail(for coin: CryptoModel) {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        coinDetailService.fetchRequest(codable: CoinDetailModel.self, urlString: urlString)
    }
    
    private func addSubscribers() {
        coinDetailService
            .$responseRecieved
            .combineLatest($selectedCoin)
            .map(generateStatsModel)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { [weak self] codable in
                self?.overViewStatsModel =  codable.overview
                self?.additionalStatsModel = codable.additional
            }
            .store(in: &cancellables)
        
        coinDetailService
            .$responseRecieved
            .sink { [weak self] codable in
                guard let self = self else { return }
                if let detailModel = codable as? CoinDetailModel {
                    self.coinDescription = detailModel.coinDescriptionWithoutHTML ?? ""
                    self.homepageURL = detailModel.links?.homepage?.first ?? ""
                    self.subredditURL = detailModel.links?.subredditURL ?? ""
                }
            }
            .store(in: &cancellables)
    }
    
    private func generateStatsModel(detailModelCodable: Codable?, coinModel: CryptoModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
            let overViewStats = overViewStatsModel(coinModel: coinModel)
            let additionalStats = additionalStatsModel(detailModelCodable: detailModelCodable, coinModel: coinModel)
            return (overViewStats, additionalStats)
    }
    
    private func overViewStatsModel(coinModel: CryptoModel) -> [StatisticsModel] {
        let price = coinModel.currentPrice.asTwoDigitNumberString
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStats = StatisticsModel(title: "Current price", value: price, percentage: pricePercentageChange)
        
        let marketCap = coinModel.marketCap?.asTwoDigitNumberString ?? "n/a"
        let marketCapChnage = coinModel.marketCapChangePercentage24H
        let marketCapStats = StatisticsModel(title: "Market capitilization", value: marketCap, percentage: marketCapChnage)

        let rank = "\(coinModel.rank)"
        let rankStats = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "\(coinModel.totalVolume?.asTwoDigitNumberString ?? "")"
        let volumeStats = StatisticsModel(title: "Volume", value: volume)
        
        return [
            priceStats,
            marketCapStats,
            rankStats,
            volumeStats
        ]
    }
    
    private func additionalStatsModel(detailModelCodable: Codable?, coinModel: CryptoModel) -> [StatisticsModel] {
        var additionalStats: [StatisticsModel] = []
        let high = coinModel.high24H?.asTwoDigitNumberString ?? "n/a"
        let highStats = StatisticsModel(title: "24H Hight", value: high)
        additionalStats.append(highStats)
        
        let low = coinModel.low24H?.asTwoDigitNumberString ?? "n/a"
        let lowStats = StatisticsModel(title: "24H Low", value: low)
        additionalStats.append(lowStats)
        
        let priceChange = coinModel.priceChange24H?.asTwoDigitNumberString ?? "n/a"
        let priceChangeStats = StatisticsModel(title: "24H price chnage", value: priceChange)
        additionalStats.append(priceChangeStats)
        
        let marketCapChange = coinModel.marketCapChange24H?.asTwoDigitNumberString ?? "n/a"
        let marketCapChangePercentage = coinModel.marketCapChangePercentage24H
        let marketCapChangeStats = StatisticsModel(title: "24H price chnage", value: marketCapChange, percentage: marketCapChangePercentage)
        additionalStats.append(marketCapChangeStats)
        
        if let detailModel = detailModelCodable as? CoinDetailModel {
            let blocTime = detailModel.blockTimeInMinutes ?? 0
            let blocTimeString = blocTime == 0 ? "n/a" : "\(blocTime)"
            let blocStats = StatisticsModel(title: "Bloc time", value: blocTimeString)
            additionalStats.append(blocStats)

            let hashing = detailModel.hashingAlgorithm ?? "n/a"
            let hashingStats = StatisticsModel(title: "Hashing algorithm", value: hashing)
            additionalStats.append(hashingStats)
        }
        return additionalStats
    }
    
    var coinName: String {
        selectedCoin.name
    }
}
