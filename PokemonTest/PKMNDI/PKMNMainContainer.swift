//
//  PKMNMainContainer.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// In this container we must register and initialize all repository
class PKMNMainContainer: PKMNMainContainerProtocol {
  // MARK: - Data Source

  /// The networking manager to make API calls. It's a concrete implementation of `PKMNNetworkingManager`.
  private var networking = PKMNNetworkingManager()
  
  /// The JSON manager to make mock calls. It's a concrete implementation of `JSONDataSourceManager`.
  private var jsonStorage = JSONDataSourceManager()

  // MARK: - Repositories

  /// The repository that stores and contains the `Pokemon` and `PokemonListItem` object retrieved.
  private var pkmnRepository: PKMNRepositoryProtocol {
    PKMNRepository(networkingWorker: networking.networkingDataSource, jsonWorker: jsonStorage.jsonDataSource)
  }

  // MARK: - Mocked UseCases
  
  /// The Use-Case to get a mocked`Pokemon`.
  var getMockedPokemonUseCase: GetMockedPokemonProtocol {
    PKMNUseCases.GetMockedPokemon(pokemonRepository: pkmnRepository)
  }
  
  /// The Use-Case to get a mocked`PokemonListItem` list.
  var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol {
    PKMNUseCases.GetMockedPokemonsList(pokemonRepository: pkmnRepository)
  }
  
  // MARK: -  UseCases
  
  /// The Use-Case to get a `Pokemon` by his id in `async` way.
  var asyncGetPokemonByIDUseCase: GetPokemonByIDProtocol {
    PKMNUseCases.GetPokemonByID(pokemonRepository: pkmnRepository)
  }
  
  /// The Use-Case to get the list of `PokemonListItem`in `async` way.
  var asyncGetPokemonsListUseCase: GetPokemonsListProtocol {
    PKMNUseCases.GetPokemonsList(pokemonRepository: pkmnRepository)
  }
  
  /// The Use-Case to get a `Pokemon` by his name in `async` way.
  var asyncSearchPokemonByNameUseCase: SearchPokemonByNameProtocol {
    PKMNUseCases.SearchPokemonByName(pokemonRepository: pkmnRepository)
  }
}
