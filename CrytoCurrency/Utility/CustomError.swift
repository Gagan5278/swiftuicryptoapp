//
//  CustomError.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/10.
//

import Foundation
enum CustomError: LocalizedError {
  case badURLResponse(url: URL)
  case unknowned
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url): return "Bad response from URL \(url)"
        case .unknowned: return "Unknown error occured"
        }
    }
    
}
