//
//  WeatherModel.swift
//  hw14
//
//  Created by Chernousova Maria on 03.11.2021.
//

import Foundation

final class WeatherModel {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func loadLocation(completion: @escaping (Result<[Location], ServiceError>) -> Void) {
        apiService.loadLocation(completion: completion)
    }
    
    func loadWeather(location: Location, completion: @escaping (Result<WeatherForDay, ServiceError>) -> Void) {
        apiService.loadWeather(location: location, completion: completion)
    }
    
}
