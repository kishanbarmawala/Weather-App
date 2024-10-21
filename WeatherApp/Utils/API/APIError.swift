//
//  APIError.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 20/10/24.
//

import Foundation

enum APIError: Error {
    case error(error: Error)
    case invalidURL
    case noData
    case decodingError
    case unknownResponse
    case cityNotFound
    
    func errorMessage() -> String {
        switch self {
            case .error(let error):
                return error.localizedDescription
            case .invalidURL:
                return "The URL provided was invalid."
            case .noData:
                return "No data was received from the server."
            case .decodingError:
                return "There was an error decoding the data."
            case .unknownResponse:
                return "The server response was not recognized."
            case .cityNotFound:
                return "Please enter a valid city name."
        }
    }
    
}
