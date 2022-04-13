//
//  TodayInfoAdapter.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import Foundation

struct TodayInfoAdapter: Hashable {
    var cityName: String
    var conditionText: String
    var conditionImageURL: URL?
    var todayTemperature: String
    
    init(_ location: Location, _ weather: WeatherForDay.Weather) {
        cityName = location.name
        conditionText = weather.condition
        conditionImageURL = URL(string: "\(ApiService.api)/static/img/weather/png/64/\(weather.stateImageID).png")
        todayTemperature = "\(Int(weather.currentTemperature))"
    }
}
