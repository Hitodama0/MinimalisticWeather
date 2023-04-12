//
//  WeatherStruct.swift
//  MinimalisticWeather
//
//  Created by Biagio Ricci on 12/04/23.
//

import Foundation


//Search
struct Search: Codable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}


//City
struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

