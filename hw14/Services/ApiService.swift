//
//  ApiService.swift
//  hw14
//
//  Created by Chernousova Maria on 06.11.2021.
//

import Foundation

enum CityID: String {
    case sanFrancisco = "san"
    case london = "london"
    case kharkiv = "kharkiv"
    
    init(name: String) {
        switch name {
        case "Kharkiv":
            self = .kharkiv
        case "London":
            self = .london
        case "San-Francisco":
            self = .sanFrancisco
        default:
            fatalError()
        }
    }
}

enum ServiceError: Error {
    case message(errorMessage: String)
    case undefined
}

class ApiService {
    static let api = "https://www.metaweather.com"
    let availableCities = ["Kharkiv", "London", "San-Francisco"]
    
    func loadLocation(completion: @escaping (Result<[Location], ServiceError>) -> Void) {
        guard let url = URL(string: "\(ApiService.api)/api/location/search/?query=\(CityID.kharkiv.rawValue)") else {
            completion(.failure(.undefined))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
            let data = data else {
                completion(.failure(.undefined))
                return
            }
            
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                completion(.success(locations))
            } catch let error as NSError {
                completion(.failure(.message(errorMessage: error.localizedDescription)))
            }
        }
        task.resume()
    }
    
    func loadWeather(location: Location, completion: @escaping (Result<WeatherForDay, ServiceError>) -> Void) {
        guard let url = URL(string: "\(ApiService.api)/api/location/\(location.id)/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data else {
                      completion(.failure(.undefined))
                      return
                  }
            
            do {
                let weather = try JSONDecoder().decode(WeatherForDay.self, from: data)
                completion(.success(weather))
            } catch let error as NSError {
                completion(.failure(.message(errorMessage: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
