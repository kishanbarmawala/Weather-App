//
//  APIService.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 19/10/24.
//

import Foundation

class APIService {
    
    private let apiKey = "a843104b332d4fb41c216252b74dd26d"
    private let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    func request<T: Decodable>(endpoint: String, queryParameters: [String: String], completion: @escaping (Result<T, APIError>) -> Void) {
        var urlComponents = URLComponents(string: "\(baseURL)\(endpoint)")
        var queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems.append(URLQueryItem(name: "appid", value: apiKey))
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            print("❌ [ERROR]: Invalid URL components: \(String(describing: urlComponents))")
            completion(.failure(APIError.invalidURL))
            return
        }
        
        print("ℹ️ [INFO]: Making API request to URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("ℹ️ [INFO]: Response of API request to URL: \(url)")
            if let error = error {
                print("❌ [ERROR]: Network request failed: \(error.localizedDescription)")
                completion(.failure(APIError.error(error: error)))
                return
            }
            
            guard let data = data else {
                print("❌ [ERROR]: No data received from the server.")
                completion(.failure(APIError.noData))
                return
            }
            
            print("ℹ️ [INFO]: Response successfully received:", data.toPrettyJSON)
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if json["cod"] as? String == "200" {
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedObject))
                    } catch let decodingError {
                        print("❌ [ERROR]: Failed to decode JSON: \(decodingError.localizedDescription)")
                        completion(.failure(APIError.decodingError))
                    }
                } else {
                    completion(.failure(APIError.cityNotFound))
                }
            } else {
                completion(.failure(APIError.unknownResponse))
            }
        }.resume()
    }
    
}
