//
//  WeatherModel.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 19/10/24.
//

import Foundation

// MARK: - ForecastModel
struct WeatherData: Codable {
    let date: String?
    let data: [List]?
}

// MARK: - ForecastModel
struct ForecastModel: Codable {
    let message: Int?
    let cod: String?
    let cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let sunset: Int?
    let country: String?
    let id: Int?
    let coord: Coord?
    let population, timezone, sunrise: Int?
    let name: String?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    let clouds: Clouds?
    let wind: Wind?
    let dt: Int?
    let dtTxt: String?
    let main: MainClass?
    let weather: [Weather]?
    let pop: Double?
    let sys: Sys?
    let visibility: Int?
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case clouds, wind, dt
        case dtTxt = "dt_txt"
        case main, weather, pop, sys, visibility, rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    let humidity: Int?
    let feelsLike, tempMin, tempMax, temp: Double?
    let pressure: Int?
    let tempKf: Double?
    let seaLevel, grndLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure
        case tempKf = "temp_kf"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let icon: String?
    let description: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
