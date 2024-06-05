//
//  ViewController+API.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 06.05.2024.
//

import UIKit

extension ViewController{
    
    
    func loadMainWatherInfo(for location: Location, completion: ((DMWeatherInfo) -> ())?) {
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=3ce97cc74d4cc39f3c06528e45532414"
            
            guard let url = URL(string: urlString)
            else {
                assertionFailure("wrong url")
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let responseError = error {
                    debugPrint(responseError.localizedDescription)
                } else if let responseData = data {
                    do {
                        let result = try JSONDecoder().decode(DMWeatherInfo.self, from: responseData)
                        debugPrint("")
                        
                        DispatchQueue.main.async {
                            completion?(result)
                        }
                    } catch let error {
                        debugPrint(error.localizedDescription)
                    }
                }
            }.resume()
        }
        
        
    }
      
}

