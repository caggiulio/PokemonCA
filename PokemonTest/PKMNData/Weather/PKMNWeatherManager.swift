//
//  PKMNWeatherManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import WeatherKit

/// The manager for the networking workers.
struct PKMNWeatherManager: Injectable {
 /// The concrete implementation of `AloyNetworkingProtocol`.
 private let weatherService: WeatherService = {
   WeatherService()
 }()
  
 /// The concrete implementation of `PKMNWeatherProtocol`.
 var weatherWorker: PKMNWeatherProtocol

 init() {
   weatherWorker = PKMNWeatherWorker(service: weatherService)
 }
}
