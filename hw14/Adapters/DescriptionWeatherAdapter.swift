//
//  DescriptionWeatherAdapter.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import Foundation

struct DescriptionWeatherAdapter: Hashable {
    var sunriseTitle: String
    var sunsetTitle: String
    var windSpeedTitle: String
    var humidityTitle: String
    
    var sunrise: String
    var sunset: String
    var windSpeed: String
    var humidity: String
    
    init(_ weather: WeatherForDay, _ weatherData: WeatherForDay.Weather) {
        sunriseTitle = GlobalConstants.Texts.sunriseTitle
        sunsetTitle = GlobalConstants.Texts.sunsetTitle
        windSpeedTitle = GlobalConstants.Texts.windSpeedTitle
        humidityTitle = GlobalConstants.Texts.humidityTitle
        
        sunrise = weather.sunriseDate.formatted(with: "H:m")
        sunset = weather.sunsetDate.formatted(with: "H:m")
        windSpeed = "\(weatherData.windDirection) \(Int(weatherData.windSpeed)) km/h"
        humidity = "\(weatherData.humidity) %"
    }
}
