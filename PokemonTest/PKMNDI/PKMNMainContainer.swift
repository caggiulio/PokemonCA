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
  private var pkmnRepository: PKMNRepositoryProtocol

  // MARK: - Mocked UseCases
  
  /// The Use-Case to get a mocked`Pokemon`.
  var getMockedPokemonUseCase: GetMockedPokemonProtocol
  
  /// The Use-Case to get a mocked`PokemonListItem` list.
  var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol
  
  // MARK: - Async UseCases
  
  /// The Use-Case to get a `Pokemon` by his id in `async` way.
  var asyncGetPokemonByIDUseCase: AsyncGetPokemonByIDProtocol
  
  /// The Use-Case to get the list of `PokemonListItem`in `async` way.
  var asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol
  
  /// The Use-Case to get a `Pokemon` by his name in `async` way.
  var asyncSearchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol
  
  // MARK: - Init

  init() {
    pkmnRepository = PKMNRepository(networkingWorker: networking.networkingDataSource, jsonWorker: jsonStorage.jsonDataSource)

    getMockedPokemonUseCase = PKMNUseCases.GetMockedPokemon(pokemonRepository: pkmnRepository)
    getMockedPokemonsListUseCase = PKMNUseCases.GetMockedPokemonsList(pokemonRepository: pkmnRepository)
        
    asyncGetPokemonByIDUseCase = PKMNUseCases.AsyncGetPokemonByID(pokemonRepository: pkmnRepository)
    asyncGetPokemonsListUseCase = PKMNUseCases.AsyncGetPokemonsList(pokemonRepository: pkmnRepository)
    asyncSearchPokemonByNameUseCase = PKMNUseCases.AsyncSearchPokemonByName(pokemonRepository: pkmnRepository)
  }
}
