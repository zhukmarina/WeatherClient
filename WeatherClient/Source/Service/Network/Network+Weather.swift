//
//  NetworkService+Weather.swift
//  WeatherClinet2024
//
//  Created by user on 06.05.2024.
//

import Foundation

typealias WeatherInfoCompletion = ((DMWeatherInfo?, Error?) -> ())

protocol NetworkServiceWeather {
    
    func loadWeather(for location: Location, completion: @escaping WeatherInfoCompletion)
}


extension NetworkService: NetworkServiceWeather {

    func loadWeather(for location: Location, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstats.weatherUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstats.appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(urlRequest: urlRequest) { (result: Result<DMWeatherInfo,Error>) in
            
            switch result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
