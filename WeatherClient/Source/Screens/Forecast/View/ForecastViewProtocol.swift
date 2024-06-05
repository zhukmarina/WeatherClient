//
//  ForecastViewProtocol.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 22.05.2024.
//

import Foundation

protocol ForecastViewProtocol{
    var delegate: ForecastViewDelegate? { get set }
    func setupWeather(temp:String)
}
