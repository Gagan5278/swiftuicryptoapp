//
//  NetworkingManager.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/10.
//

import Foundation
import Combine
class NetworkingManager {
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try handleResponse(output: $0, url: url)}
            .retry(2)
            .eraseToAnyPublisher()
    }
    
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
            throw CustomError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error)
        }
    }
    
}
