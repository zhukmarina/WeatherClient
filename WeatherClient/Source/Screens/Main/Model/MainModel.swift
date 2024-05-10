//
//  MainModel.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import UIKit

class MainModel{
    
    weak var delegate: MainModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataWeather
    
    init(delegate: MainModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}

extension MainModel: MainModelProtocol {
    func loadData() {
        
        
        
        if let storageData = storageService.fetchAllWeatherInfo().last{
            delegate?.dataDidLoad(with: storageData)
        }else{
            DispatchQueue.global(qos: .default).async { [weak self] in
                
            
            let location = Location(latitude: 49.989619, longitude: 36.241182)
            
                self?.networkService.loadWeather(for: location) {[weak self] weatherInfo, error in
                DispatchQueue.main.async{
                if let weather = weatherInfo {
                    self?.storageService.insertWeatherInfo(with: weather)
                    if let fetchedWeather = self?.storageService.fetchAllWeatherInfo().last{
                        self?.delegate?.dataDidLoad(with: fetchedWeather)
                    }
                    }
                    }
                }
            }
        }
    }
}
