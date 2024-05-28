//
//  WeatherUtils.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 27.05.2024.
//

import Foundation

struct WeatherUtils {
    static func convertToCelsius(kelvin: Double) -> String {
        let celsius = kelvin - 273.15
        return String(format: "%.0f°C", celsius)
    }

    static func formatDate(from timestamp: TimeInterval, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
    
    static func formatTime(from timestamp: TimeInterval, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
    
    static func formatDayAndDate(from timestamp: TimeInterval, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d" 
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
}
