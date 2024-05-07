//
//  ViewController.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 06.05.2024.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()
    }
}

private extension ViewController{
    
    func loadData(){
        
        let cityName = "Kyiv"
        
        if let storageData = fetchAllWeatherData().last{
            dataDidLoad(with: storageData)
        }else{
            loadMainWeatherInfo(for: cityName){[weak self] weatherInfo in
                self?.storeWeatherInfo(weatherInfo)
                if let data = self?.fetchAllWeatherData().last{
                    self?.dataDidLoad(with: data)
                }
            }
        }
    }

    func dataDidLoad(with data: CDWeatherInfo){
        debugPrint("temp is:\(data.temperature)")
    }
}
