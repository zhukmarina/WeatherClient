//
//  ViewController+CoreData.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 06.05.2024.
//

import UIKit

extension ViewController{
    
    func storeWeatherInfo (_ info: DMWeatherInfo){
        let coreDataService = CoreDataService.shared
        
        coreDataService.insertWeatherInfo(with: info)
    }
    func fetchAllWeatherData() -> [CDWeatherInfo] {
        let coreDataService = CoreDataService.shared
        return coreDataService.fetchAllWeatherInfo()
    }
}
