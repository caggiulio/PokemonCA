//
//  UseCaseDepencyManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 08/11/22.
//

import Foundation

/// The struct responsible to add the dependencies of the architecture of the app.
struct UseCaseDepencyManager {
  // MARK: - Computed Properties
  
  /// The Use-Case to get a mocked`Pokemon`.
  var getMockedPokemonUseCase: GetMockedPokemonProtocol {
    PKMNUseCases.GetMockedPokemon()
  }
  
  /// The Use-Case to get a mocked`PokemonListItem` list.
  var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol {
    PKMNUseCases.GetMockedPokemonsList()
  }
  
  // MARK: -  UseCases
  
  /// The Use-Case to get a `Pokemon` by his id in `async` way.
  var asyncGetPokemonByIDUseCase: GetPokemonByIDProtocol {
    PKMNUseCases.GetPokemonByID()
  }
  
  /// The Use-Case to get the list of `PokemonListItem`in `async` way.
  var asyncGetPokemonsListUseCase: GetPokemonsListProtocol {
    PKMNUseCases.GetPokemonsList()
  }
  
  /// The Use-Case to get a `Pokemon` by his name in `async` way.
  var asyncSearchPokemonByNameUseCase: SearchPokemonByNameProtocol {
    PKMNUseCases.SearchPokemonByName()
  }
  
  /// Set the id for a selected `Pokemon`.
  var setSelectedPokemonID: SetSelectedPokemonIDProtocol {
    PKMNUseCases.SetSelectedPokemonID()
  }
  
  /// Get the id for a selected `Pokemon`.
  var getSelectedPokemonID: GetSelectedPokemonIDProtocol {
    PKMNUseCases.GetSelectedPokemonID()
  }
  
  /// Get the current weather for the current location.
  var getCurrentWeatherUseCase: GetCurrentWeatherProtocol {
    PKMNUseCases.GetCurrentWeather()
  }
  
  /// Get the overall of the Pokemon.
  var getPokemonOverall: GetOverallProtocol {
    PKMNUseCases.GetPokemonOverall()
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
    resolver.add(getMockedPokemonUseCase)
    resolver.add(getMockedPokemonsListUseCase)
    resolver.add(asyncGetPokemonByIDUseCase)
    resolver.add(asyncGetPokemonsListUseCase)
    resolver.add(asyncSearchPokemonByNameUseCase)
    resolver.add(setSelectedPokemonID)
    resolver.add(getSelectedPokemonID)
    resolver.add(getCurrentWeatherUseCase)
    resolver.add(getPokemonOverall)
  }
}
