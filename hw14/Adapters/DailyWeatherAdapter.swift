//
//  DailyWeatherAdapter.swift.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import Foundation

struct DailyWeatherAdapter: Hashable {
    var day: String
    var conditionImageURL: URL?
    var dayTemperature: String
    var nightTemperature: String
    
    init(_ weather: WeatherForDay.Weather) {
        day = weather.date.formatted(with: "EEEE")
        conditionImageURL = URL(string: "\(ApiService.api)/static/img/weather/png/64/\(weather.stateImageID).png")
        dayTemperature = "D: \(Int(weather.maxTemperature))°"
        nightTemperature = "N: \(Int(weather.minTemperature))°"
    }
}
