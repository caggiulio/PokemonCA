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
  
  /// The location worker.
  private var locationWorker: PKMNLocationProtocol
  
  // MARK: - Init
  
  /// The `init` with the needed workers.
  /// - Parameters:
  ///  - weatherWorker: The weather worker.
  ///  - locationWorker: The `CoreLocation` worker.
  init(weatherWorker: PKMNWeatherProtocol, locationWorker: PKMNLocationProtocol) {
    self.weatherWorker = weatherWorker
    self.locationWorker = locationWorker
  }
  
  func getCurrentWeather() async throws -> CurrentWeather {
    guard let location = try await locationWorker.getCurrentLocation() else {
      throw PKMNError.resourceNotFound
    }
    return try await weatherWorker.getCurrentWeather(location: location)
  }
}
