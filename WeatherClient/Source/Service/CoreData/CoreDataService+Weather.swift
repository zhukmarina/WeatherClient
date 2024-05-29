import CoreData

import CoreData

protocol CoreDataWeather {
    func insertWeatherInfo(with info: DMWeatherInfo)
    func insertForecastWeather(with info: DMForecastWeather, for cityName: String?)
    func fetchAllWeatherInfo() -> [CDWeatherInfo]
    func fetchWeatherDetails(for weatherInfo: CDWeatherInfo) -> CDWeatherDetails?
    func fetchAllWeatherInfoSorted(by key: String, ascending: Bool) -> [CDWeatherInfo] // Новий метод
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
        weatherInfoEntity.dt = info.dt

        for details in info.weather {
            if let detailsEntity = insertWeatherDetails(with: details) {
                weatherInfoEntity.addToWeatherDetails(detailsEntity)
            }
        }

        save(context: context)
    }

    func insertForecastWeather(with info: DMForecastWeather, for cityName: String?) {
      

        for forecast in info.list {
            let forecastInfoEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherInfo", in: context)!
            guard let forecastInfoEntity = NSManagedObject(entity: forecastInfoEntityDescription, insertInto: context) as? CDWeatherInfo else {
                assertionFailure("Failed to create CDWeatherInfo")
                return
            }
            
            forecastInfoEntity.cityName = cityName
            forecastInfoEntity.dt = Double(forecast.dt)
            forecastInfoEntity.temperature = forecast.main.temp
            
            for details in forecast.weather {
                if let detailsEntity = insertWeatherDetails(with: details) {
                    forecastInfoEntity.addToWeatherDetails(detailsEntity)
                }
            }

            // Log the data being saved for debugging
            print("Saving data with dt: \(forecast.dt), temperature: \(forecast.main.temp)")
        }

        save(context: context)
    }

    func fetchAllWeatherInfo() -> [CDWeatherInfo] {
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["weatherDetails"] // Жадная загрузка
        
        let sortDescriptor = NSSortDescriptor(key: "dt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchedResult = try context.fetch(fetchRequest)
           
            for weatherInfo in fetchedResult {
                print("Loaded data with dt: \(weatherInfo.dt), temperature: \(weatherInfo.temperature)")
            }
            return fetchedResult
        } catch {
            print("Failed to fetch weather info: \(error)")
            return []
        }
    }

    func fetchAllWeatherInfoSorted(by key: String, ascending: Bool) -> [CDWeatherInfo] {
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: key, ascending: ascending)]
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch sorted weather info: \(error)")
            return []
        }
    }

//    func deleteAllWeatherInfo() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDWeatherInfo.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//
//            if let fetchedResults = try context.fetch(fetchRequest) as? [CDWeatherInfo] {
//                for object in fetchedResults {
//                    context.delete(object)
//                }
//                try context.save()
//            }
//        } catch {
//            print("Failed to delete weather info: \(error)")
//        }
//    }
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

    func insertWeatherDetails(with details: DMForecastWeather.Weather) -> CDWeatherDetails? {
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
