//
//  DMWeatherInfo.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 06.05.2024.
//

import Foundation

//DM - Domain Model
struct DMWeatherInfo: Decodable{
    let id: Int
    let name: String
    let dt: Int
    let weather:[Weather]
    let main: Main
    let wind: Wind
    
    struct Weather: Decodable {
        let id: Int
        let main:String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable{
        let temp: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Wind: Decodable{
        let speed: Double
    }
    
}

