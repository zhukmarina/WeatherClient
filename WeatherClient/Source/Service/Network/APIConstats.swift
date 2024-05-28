//
//  APIConstats.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import Foundation

struct APIConstats {
   
        
        static let baseUrl = "https://api.openweathermap.org"
        static let dataPath = "/data"
        static let apiVersion = "2.5"
        static let weatherPath = "/weather"
        static let forecastPath = "/forecast"
    
        static let appId = "cdcac2d1ff76a517515e446368a0f5af"
        
        static func weatherUrl() -> String {
            return baseUrl + dataPath + "/" + apiVersion + weatherPath
                }
        
        static func forecastUrl()-> String {
            return baseUrl + dataPath + "/" + apiVersion + forecastPath
        
    }
}
