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

  private var networking = PKMNNetworkingManager()
  private var jsonStorage = JSONDataSourceManager()

  // MARK: - Repositories

  private var pkmnRepository: PKMNRepositoryProtocol

  // MARK: - UseCases

  public var getPokemonByIDUseCase: GetPokemonByIDProtocol
  public var getPokemonsListUseCase: GetPokemonsListProtocol
  public var searchPokemonByNameUseCase: SearchPokemonByNameProtocol

  /// Mocked
  public var getMockedPokemonUseCase: GetMockedPokemonProtocol
  public var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol

  public init() {
    /// Repository
    pkmnRepository = PKMNRepository(networkingWorker: networking.networkingDataSource, jsonWorker: jsonStorage.jsonDataSource)

    /// Real
    getPokemonByIDUseCase = PKMNUseCases.GetPokemonByID(pokemonRepository: pkmnRepository)
    getPokemonsListUseCase = PKMNUseCases.GetPokemonsList(pokemonRepository: pkmnRepository)
    searchPokemonByNameUseCase = PKMNUseCases.SearchPokemonByName(pokemonRepository: pkmnRepository)

    /// Mocked
    getMockedPokemonUseCase = PKMNUseCases.GetMockedPokemon(pokemonRepository: pkmnRepository)
    getMockedPokemonsListUseCase = PKMNUseCases.GetMockedPokemonsList(pokemonRepository: pkmnRepository)
  }
}
