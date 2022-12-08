//
//  PKMNWeatherProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import Foundation

/// The protocols to defines the methods needed to store and retrieve `Weather` from the repository.
protocol PKMNWeatherRepositoryProtocol: Injectable {
  func getCurrentWeather() async throws -> CurrentWeather
}
