//
//  ArchitectureDependencyManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 08/11/22.
//

import Foundation

/// The struct responsible to add the dependencies of the architecture of the app.
struct ArchitectureDependencyManager {
  // MARK: - Computed Properties
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  private var assembler: PKMNSwiftUIAssembler {
    PKMNSwiftUIAssembler()
  }
  
  /// The networking manager to make API calls. It's a concrete implementation of `PKMNNetworkingManager`.
  private var networkingManager: PKMNNetworkingManager {
    PKMNNetworkingManager()
  }
  
  /// The JSON manager to make mock calls. It's a concrete implementation of `JSONDataSourceManager`.
  private var jsonManager: JSONDataSourceManager {
    JSONDataSourceManager()
  }
  
  /// The weather manager to make weather calls.
  private var weatherManager: PKMNWeatherManager {
    PKMNWeatherManager()
  }
  
  /// The repository that stores and contains the `Pokemon` and `PokemonListItem` object fetched.
  private var pokemonRepository: PKMNRepositoryProtocol {
    PKMNRepository(networkingWorker: networkingManager.networkingDataSource, jsonWorker: jsonManager.jsonDataSource)
  }
  
  /// The repository that stores and contains the fetched `Weather` objects.
  private var weatherRepository: PKMNWeatherRepositoryProtocol {
    PKMNWeatherRepository(weatherWorker: weatherManager.weatherWorker)
  }
    
  // MARK: - Init
  
  /// The init of the manager.
  init() {
    addDependencies()
  }
    
  // MARK: - Private Methods
  
  /// This method add the depencies to shared `Resolver` instance.
  private func addDependencies() {
    let resolver = Resolver.shared
    resolver.add(networkingManager)
    resolver.add(jsonManager)
    resolver.add(pokemonRepository)
    resolver.add(assembler)
    resolver.add(weatherManager)
    resolver.add(weatherRepository)
  }
}
