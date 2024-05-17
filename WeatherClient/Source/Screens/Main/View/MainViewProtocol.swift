//
//  MainViewProtocol.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import Foundation

protocol MainViewProtocol{
    func setupWeather(temp:String,cityName: String, hum:String, wind:String, date:String)
}
