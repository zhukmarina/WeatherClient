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
    
    override func loadView() {
        let mainView = MainView(frame: .zero)
        mainView.delegate = self
        contentView = mainView
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let dataToShow = "\(data.temperature)"
        contentView.setupWeather(text: dataToShow)
    }
    
    
}
