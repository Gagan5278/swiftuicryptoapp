//
//  CoinImageServiceRequest.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
import SwiftUI
import Combine
protocol CoinImageServiceRequestProtocol {
    init(urlString: String)
}
class CoinImageServiceRequest: ObservableObject, CoinImageServiceRequestProtocol {
    @Published var coinImage: UIImage?
    var imageSubscription: AnyCancellable?
    
    // MARK: - init
    required init(urlString: String) {
        getCoinImage(from: urlString)
    }
    
    private func getCoinImage(from urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        imageSubscription = NetworkingManager.download(from: imageURL)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] image in
                self?.coinImage = image
                self?.imageSubscription?.cancel()
            }
    }
}
