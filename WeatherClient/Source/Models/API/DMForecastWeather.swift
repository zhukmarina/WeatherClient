//
//  DMForecastWeather.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 27.05.2024.
//

import Foundation

struct DMForecastWeather: Codable {
    
    let list: [WeatherForecast]
    
    
    struct WeatherForecast: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
    }
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Codable {
        let all: Int
    }
}
