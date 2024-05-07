//
//  ViewController+API.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 06.05.2024.
//

import UIKit

extension ViewController{
    
    
    func loadMainWeatherInfo(for cityName: String ,completion: ((DMWeatherInfo)->())?){
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName),ua&appid=cdcac2d1ff76a517515e446368a0f5af"
            
           guard let url = URL(string: urlString)
            else {
               assertionFailure("Wrong url")
               return
           }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let responseError = error{
                    debugPrint(responseError.localizedDescription )
                }else if let responseData = data {
                    
                    do{
                        let result = try JSONDecoder().decode(DMWeatherInfo.self, from: responseData)
                        debugPrint(result)
                      
                        DispatchQueue.main.async {
                            completion?(result)
                        }
                        
                    }catch let error{
                        debugPrint(error.localizedDescription)
                    }
                    
                }
                
            }.resume()
            
        }
        }
      
}

