//
//  PKMNWeatherWorkerProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import Foundation

/// The protocol with the weather method.
protocol PKMNWeatherProtocol {
  /// Get the current weather condition.
  func getCurrentWeather(location: CurrentLocation) async throws -> CurrentWeather
}
