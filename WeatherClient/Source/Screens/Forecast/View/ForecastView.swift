//
//  ForecastView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 22.05.2024.
//


import UIKit

class ForecastView: UIView{
    
    weak var delegate: ForecastViewDelegate?
    
    @IBOutlet weak var todayForecastCollectionView: UICollectionView!
    
    
    @IBOutlet weak var nextWeekColectionView: UICollectionView!
}


//extension ForecastView: ForecastViewProtocol{
//    func setupWeather(temp: String, cityName: String, hum: String, wind: String, date: String, mainInfo: String, icon: String) {
//        <#code#>
//    }
//    
    
//}
