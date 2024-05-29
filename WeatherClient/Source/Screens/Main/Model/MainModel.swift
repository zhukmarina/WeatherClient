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
    
    private var selectCityName: String?
    
    private var oneHourInSeconds: TimeInterval {
        return 3600
    }
    
    private var currentTime: TimeInterval {
        return Date().timeIntervalSince1970
    }
}

extension MainModel: MainModelProtocol {
    var cityName: String? {
        get {
            return selectCityName
        }
    }
    
    func loadData() {
        let sortedWeatherData = storageService.fetchAllWeatherInfoSorted(by: "dt", ascending: false)
        
        if let latestWeatherData = sortedWeatherData.last {
            let timeDifference = currentTime - TimeInterval(latestWeatherData.dt)
            let cityNameMatches = latestWeatherData.cityName == selectCityName
            
            if timeDifference < oneHourInSeconds && cityNameMatches {
                print("Using stored data: \(latestWeatherData)")
                loadWeatherDetails(for: latestWeatherData)
            } else {
                print("Stored data is outdated or city name has changed. Fetching from API.")
                fetchWeatherFromAPI()
            }
        } else {
            print("No stored data found. Fetching from API.")
            fetchWeatherFromAPI()
        }
    }
    
    private func fetchWeatherFromAPI() {
        DispatchQueue.global(qos: .default).async { [weak self] in
            let location = Location(latitude: 50.4333, longitude: 30.5167)
            self?.networkService.loadWeather(for: location) { [weak self] weatherInfo, error in
                DispatchQueue.main.async {
                    if let weather = weatherInfo {
                        print("Fetched weather data from API: \(weather)")
                        self?.storageService.insertWeatherInfo(with: weather)
                        if let fetchedWeather = self?.storageService.fetchAllWeatherInfoSorted(by: "dt", ascending: false).last {
                            print("Fetched new weather data from storage: \(fetchedWeather)")
                            self?.loadWeatherDetails(for: fetchedWeather)
                        } else {
                            print("Failed to fetch new weather data from storage after inserting.")
                        }
                    } else if let error = error {
                        print("Error fetching weather data from API: \(error)")
                    }
                }
            }
        }
    }
    
    private func loadWeatherDetails(for weatherInfo: CDWeatherInfo) {
        weatherInfo.weatherDetails?.allObjects.forEach { (detail) in
            if let weatherDetail = detail as? CDWeatherDetails {
                // Додаткові дії, якщо необхідно
            }
        }
        selectCityName = weatherInfo.cityName
        delegate?.dataDidLoad(with: weatherInfo)
    }
}
