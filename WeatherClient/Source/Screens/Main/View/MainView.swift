//
//  MainView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import UIKit

class MainView: UIView{
    
    weak var delegate: MainViewDelegate?
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNamelabel: UILabel!
    
    @IBOutlet weak var dateLaabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humCounterLabel: UILabel!
    
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var mainInfoLabel: UILabel!
    func setupUI() {

    }
    

}

extension MainView: MainViewProtocol{
    
    
    func setupWeather(temp: String, cityName: String, hum:String, wind:String, date:String, mainInfo: String, icon: String) {
        tempLabel.text = "\(temp)°C"
        cityNamelabel.text = cityName
        humCounterLabel.text = "\(hum)%"
        windLabel.text = "\(wind) m/s"
        dateLaabel.text = date
        mainInfoLabel.text = mainInfo
        
        
       
    }
}


