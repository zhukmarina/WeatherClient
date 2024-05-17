//
//  MainViewController.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var model: MainModelProtocol!
    var contentView: MainViewProtocol!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mainView = view as? MainView else {
            fatalError("MainView is not connected properly in the storyboard")
        }
        contentView = mainView
        mainView.delegate = self
        setupInitialState()
        model.loadData()
    }
    
    
    private func setupInitialState() {
        let mainModel = MainModel(delegate: self)
        model = mainModel
    }
}

extension MainViewController: MainViewDelegate{
   
    
    
    
}

extension MainViewController: MainModelDelegate{

    
    func dataDidLoad(with data: CDWeatherInfo) {
        let temperatureCelsius = data.temperature - 273.15
        let temperature = String(format: "%.0f", temperatureCelsius)
        let windSpeed = data.wind * 10
        
        let cityName = "\( data.cityName)"
        let hum = "\(data.humidity)"
        let date = "\(data.dt)"
        let windy = String(format: "%.0f", windSpeed)
   
        
        contentView.setupWeather(
            temp: temperature,
            cityName:cityName,
            hum: hum,
            wind: windy,
            date: date)

    }
    
    
}
