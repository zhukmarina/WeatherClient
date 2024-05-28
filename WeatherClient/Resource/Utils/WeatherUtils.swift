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

    static func formatDate(from timestamp: Int, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
    
    static func formatTime(from timestamp: Int, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
    
    static func formatDayAndDate(from timestamp: Int, localeIdentifier: String = "en_EN") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d" // EEE for day of week, d for day of month
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: date)
    }
}
