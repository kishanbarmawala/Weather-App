//
//  WeatherViewModel.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 19/10/24.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    private let apiService = APIService()
    
    func fetchWeatherData(coordinate: CLLocationCoordinate2D? = nil, city: String? = nil, onSuccess: @escaping ([WeatherData], City) -> (), onError: @escaping (APIError) -> ()) {
        
        var queryParameters = [String: String]()
        
        if let coordinate = coordinate {
            queryParameters["lat"] = String(coordinate.latitude)
            queryParameters["lon"] = String(coordinate.longitude)
        }
        
        if let city = city {
            queryParameters["q"] = city
        }
        
        apiService.request(endpoint: "forecast", queryParameters: queryParameters) { (result: Result<ForecastModel, APIError>) in
            switch result {
            case .success(let successData):
                let groupedData = Dictionary(grouping: successData.list ?? []) { String($0.dtTxt?.prefix(10) ?? "") }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let sortedData = groupedData.sorted {
                    guard let date1 = dateFormatter.date(from: $0.key),
                          let date2 = dateFormatter.date(from: $1.key) else {
                        return false
                    }
                    return date1 < date2
                }
                
                let finalData = sortedData.map({ WeatherData(date: $0.key, data: $0.value) })
                DispatchQueue.main.async {
                    onSuccess(finalData, successData.city!)
                }
            case .failure(let failureData):
                DispatchQueue.main.async {
                    onError(failureData)
                }
            }
        }
    }
    
}
