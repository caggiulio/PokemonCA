//
//  PKMNWeatherManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import WeatherKit

/// The manager for the weather workers.
struct PKMNWeatherManager: Injectable {
  /// The Apple weather service.
  private let weatherService: WeatherService = {
    WeatherService()
  }()
  
  /// The concrete implementation of `PKMNWeatherProtocol`.
  var weatherWorker: PKMNWeatherProtocol

  init() {
    weatherWorker = PKMNWeatherWorker(service: weatherService)
  }
}
