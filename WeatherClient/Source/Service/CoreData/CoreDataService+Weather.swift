import CoreData

protocol CoreDataWeather {
    func insertWeatherInfo(with info: DMWeatherInfo)
    
    func fetchAllWeatherInfo() -> [CDWeatherInfo]
    func fetchWeatherDetails(for weatherInfo: CDWeatherInfo) -> CDWeatherDetails?
    
}

extension CoreDataService: CoreDataWeather {
    func fetchWeatherDetails(for weatherInfo: CDWeatherInfo) -> CDWeatherDetails? {
           
           guard let weatherDetails = weatherInfo.weatherDetails?.anyObject() as? CDWeatherDetails else {
               return nil
           }
           return weatherDetails
       }
    
    func insertWeatherInfo(with info: DMWeatherInfo) {
        let weatherInfoEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherInfo", in: context)!
        guard let weatherInfoEntity = NSManagedObject(entity: weatherInfoEntityDescription, insertInto: context) as? CDWeatherInfo else {
            assertionFailure("Failed to create CDWeatherInfo")
            return
        }
        
        weatherInfoEntity.id = Int32(info.id)
        weatherInfoEntity.cityName = info.name
        weatherInfoEntity.temperature = info.main.temp
        weatherInfoEntity.pressure = Int32(info.main.pressure)
        weatherInfoEntity.humidity = Int32(info.main.humidity)
        weatherInfoEntity.speed = info.wind.speed
        weatherInfoEntity.dt = Int32(Int64(info.dt))
       
        for details in info.weather {
            if let detailsEntity = insertWeatherDetails(with: details) {
                weatherInfoEntity.addToWeatherDetails(detailsEntity)
            }
        }
        
        save(context: context)
    }
    
    func fetchAllWeatherInfo() -> [CDWeatherInfo] {
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["weatherDetails"] // Жадная загрузка связанных объектов
        let fetchedResult = fetchDataFromEntity(CDWeatherInfo.self, fetchRequest: fetchRequest)
        return fetchedResult
    }
}

private extension CoreDataService {
    func insertWeatherDetails(with details: DMWeatherInfo.Weather) -> CDWeatherDetails? {
        let weatherDetailsEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherDetails", in: context)!
        guard let weatherDetailsEntity = NSManagedObject(entity: weatherDetailsEntityDescription, insertInto: context) as? CDWeatherDetails else {
            assertionFailure("Failed to create CDWeatherDetails")
            return nil
        }
        
        weatherDetailsEntity.id = Int32(details.id)
        weatherDetailsEntity.icon = details.icon
        weatherDetailsEntity.mainInfo = details.main
        weatherDetailsEntity.details = details.description
      
        return weatherDetailsEntity
    }
}
