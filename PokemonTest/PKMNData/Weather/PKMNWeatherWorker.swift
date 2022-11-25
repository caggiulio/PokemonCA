//
//  PKMNWeatherWorker.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import WeatherKit
import CoreLocation

/// The concrete implementation of `PKMNWeatherProtocol`.
struct PKMNWeatherWorker: PKMNWeatherProtocol, Injectable {
  // MARK: - Stored Properties
  
  private var service: WeatherService
  
  // MARK: - Init
  
  /// The `init` of the `PKMNWeatherWorker`.
  /// - Parameter service: The `WeatherService` to call weather APIs.
  init(service: WeatherService) {
    self.service = service
  }
  
  func getCurrentWeather() async throws -> CurrentWeather {
    do {
      let weather = try await service.weather(for: CLLocation(latitude: 37.7749, longitude: 122.4194), including: .current)
      return CurrentWeather(temperature: weather.temperature.value, condition: weather.condition.description, symbolName: weather.symbolName)
    } catch let error {
      throw PKMNError.genericError(error.localizedDescription)
    }
  }
}
