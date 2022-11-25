//
//  PKMNWeatherRepository.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import Foundation

/// The concrete implementation of `PKMNWeatherRepositoryProtocol`.
class PKMNWeatherRepository: PKMNWeatherRepositoryProtocol {
  /// The weather worker.
  private var weatherWorker: PKMNWeatherProtocol
  
  // MARK: - Init
  
  /// The `init` with the needed workers.
  /// - Parameter weatherWorker: The weather worker.
  init(weatherWorker: PKMNWeatherProtocol) {
    self.weatherWorker = weatherWorker
  }
  
  func getCurrentWeather() async throws -> CurrentWeather {
    try await weatherWorker.getCurrentWeather()
  }
}
