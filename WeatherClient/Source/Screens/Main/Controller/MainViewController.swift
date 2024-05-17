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

extension MainViewController: MainModelDelegate {

    func dataDidLoad(with data: CDWeatherInfo) {
        let dateString = formatDate(from: Int(data.dt))
        let temperatureCelsius = data.temperature - 273.15
        let temperature = String(format: "%.0f", temperatureCelsius)
        let cityName = data.cityName ?? ""
        let hum = "\(data.humidity)"
        let windSpeed = String(format: "%.0f", data.speed)
        
        let weatherDetails = extractWeatherDetails(from: data.weatherDetails)
        
        contentView.setupWeather(
            temp: temperature,
            cityName: cityName,
            hum: hum,
            wind: windSpeed,
            date: dateString,
            mainInfo: weatherDetails.mainInfo,
            icon: weatherDetails.icon
        )
    }

    func formatDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_EN")
        
        return dateFormatter.string(from: date)
    }

    func extractWeatherDetails(from weatherDetails: NSSet?) -> (mainInfo: String, icon: String) {
        var mainInfo: String = ""
        var icon: String = ""
        
        if let details = weatherDetails?.allObjects as? [CDWeatherDetails] {
            for detail in details {
                if let detailMainInfo = detail.mainInfo, !detailMainInfo.isEmpty {
                    mainInfo += "\(detailMainInfo) "
                }
                if let detailIcon = detail.icon, !detailIcon.isEmpty {
                    icon = detailIcon
                }
            }
        }
        
        return (mainInfo, icon)
    }
}
