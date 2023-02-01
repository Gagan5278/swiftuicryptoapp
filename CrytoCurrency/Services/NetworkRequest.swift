//
//  NetworkRequest.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/10.
//

import Foundation
import Combine
class NetworkRequest {
    @Published var responseRecieved: Codable?
    private var coinSubscription: AnyCancellable?
    
    // MARK: - init
    init() {}
    
    func fetchRequest<T: Codable>(codable: T.Type,  urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        coinSubscription =  NetworkingManager.download(from: url)
            .decode(type: codable.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] recievedModel in
                self?.responseRecieved = recievedModel
                self?.coinSubscription?.cancel()
            })
    }
}
