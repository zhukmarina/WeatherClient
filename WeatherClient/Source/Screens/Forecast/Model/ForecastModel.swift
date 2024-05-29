import UIKit

class ForecastModel {
    
    weak var delegate: ForecastModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataWeather
    
    init(delegate: ForecastModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}

extension ForecastModel: ForecastModelProtocol {
    func loadData(for cityName:String?) {
        let storageData = storageService.fetchAllWeatherInfo().filter({$0.cityName == cityName})
        
        if storageData.count > 1 {
            delegate?.dataDidLoad(with: storageData)
            print("Loaded data from storage: \(storageData.prefix(5))")
        } else {
            DispatchQueue.global(qos: .default).async { [weak self] in
                let location = Location(latitude: 50.4333, longitude: 30.5167)
                self?.networkService.loadWeatherForecast(for: location) { [weak self] forecastInfo, error in
                    DispatchQueue.main.async {

                        if var forecast = forecastInfo {
        
                            self?.storageService.insertForecastWeather(with: forecast, for: cityName)
  
                            print("Loaded data from API and saved to storage: \(forecast)")
                            
                            if let fetchedForecast = self?.storageService.fetchAllWeatherInfo() {
                                self?.delegate?.dataDidLoad(with: fetchedForecast)
                            }
                        } else if let error = error {
                            print("Failed to load data from API: \(error)")
                           
                        }
                    }
                }
            }
        }
    }
}
