//
//  MainModelDelegate.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import Foundation

protocol MainModelDelegate: AnyObject{
    func dataDidLoad(with data: CDWeatherInfo)
}
