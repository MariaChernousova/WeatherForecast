//
//  WeatherViewModel.swift
//  hw14
//
//  Created by Chernousova Maria on 03.11.2021.
//

import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func update(with adapter: TodayInfoAdapter)
    func update(with adapter: TodayWeatherAdapter)
    func update(with adapters: [DailyWeatherAdapter])
    func update(with adapter: DescriptionWeatherAdapter)
}

final class WeatherViewModel {
    private let model: WeatherModel
    
    private let requestQueue = DispatchQueue(label: "com.weather.view.model.request.queue")
    private let semaphore = DispatchSemaphore(value: 1)
    
    private var locations: [Location] = []
    var weather: WeatherForDay?
    
    var todayInfoAdapter: TodayInfoAdapter? = nil {
        didSet {
            perform {
                guard let todayInfoAdapter = self.todayInfoAdapter else { return }
                self.delegate?.update(with: todayInfoAdapter)
            }
        }
    }
    
    var todayWeatherAdapter: TodayWeatherAdapter? = nil {
        didSet {
            perform {
                guard let todayWeatherAdapter = self.todayWeatherAdapter else { return }
                self.delegate?.update(with: todayWeatherAdapter)
            }
        }
    }
    
    var dailyWeatherAdapters: [DailyWeatherAdapter] = [] {
        didSet {
            perform {
                self.delegate?.update(with: self.dailyWeatherAdapters)

            }
        }
    }
    
    var descriptionWeatherAdapter: DescriptionWeatherAdapter? = nil {
        didSet {
            perform {
                guard let descriptionWeatherAdapter = self.descriptionWeatherAdapter else { return }
                self.delegate?.update(with: descriptionWeatherAdapter)
            }
        }
    }
    
    weak var delegate: WeatherViewModelDelegate?
    
    
    init(model: WeatherModel) {
        self.model = model
    }
    
    func load() {
        requestQueue.async { [weak self, weak model] in
            self?.semaphore.wait()
            model?.loadLocation { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let locations):
                    self.locations = locations
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.semaphore.signal()
            }
        }
        
        requestQueue.async { [weak self, weak model] in
            self?.semaphore.wait()
            guard let firstLocation = self?.locations.first else { return }
            model?.loadWeather(location: firstLocation) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.weather = weather
                    
                        guard let locationFirst = self.locations.first,
                              let weatherData = weather.data.first else { return }
                        self.todayInfoAdapter = TodayInfoAdapter(locationFirst, weatherData)
                    self.todayWeatherAdapter = TodayWeatherAdapter(weatherData)
                    self.dailyWeatherAdapters = weather.data.map { DailyWeatherAdapter($0) }
                    self.descriptionWeatherAdapter = DescriptionWeatherAdapter(weather, weatherData)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.semaphore.signal()
            }
        }
    }
    
    private func perform(actionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            actionHandler()
        }
    }
}

