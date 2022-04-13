//
//  TodayWeatherAdapter.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import Foundation

struct TodayWeatherAdapter: Hashable {
    var date: String
    var today: String
    var dayTemperature: String
    var nightTemperature: String

    init(_ weather: WeatherForDay.Weather) {
        date = weather.date.formatted(with: "MMM dd")
        today = "Today"
        dayTemperature = "D: \(Int(weather.maxTemperature))°"
        nightTemperature = "N: \(Int(weather.minTemperature))°"
    }
}
