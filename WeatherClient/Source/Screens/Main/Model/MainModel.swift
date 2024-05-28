import UIKit

class MainModel {
    
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
//        if let storageData = storageService.fetchAllWeatherInfo().last {
//            loadWeatherDetails(for: storageData)
//            print(storageData)
//        } else {
            DispatchQueue.global(qos: .default).async { [weak self] in
                let location = Location(latitude: 50.4333, longitude: 30.5167)
                self?.networkService.loadWeather(for: location) { [weak self] weatherInfo, error in
                    DispatchQueue.main.async {
                        if let weather = weatherInfo {
                            self?.storageService.insertWeatherInfo(with: weather)
                            if let fetchedWeather = self?.storageService.fetchAllWeatherInfo().last {
                                self?.loadWeatherDetails(for: fetchedWeather)
                            }
                        }
//                    }
                }
            }
        }
    }

    private func loadWeatherDetails(for weatherInfo: CDWeatherInfo) {
        weatherInfo.weatherDetails?.allObjects.forEach { (detail) in
            if let weatherDetail = detail as? CDWeatherDetails {
                
            }
        }
        delegate?.dataDidLoad(with: weatherInfo)
    }
}
