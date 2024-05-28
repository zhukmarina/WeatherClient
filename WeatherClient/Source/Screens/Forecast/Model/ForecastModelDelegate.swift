//
//  ForecastModelDelegate.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 22.05.2024.
//

import Foundation

protocol ForecastModelDelegate: AnyObject {
    func dataDidLoad(with data: [CDWeatherInfo]) // Оновлено параметр
}

