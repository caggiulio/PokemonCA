//
//  PKMNRepository.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The concrete implementation of `PKMNRepositoryProtocol`.
class PKMNRepository: PKMNRepositoryProtocol {
  /// The networking worker.
  private var networkingWorker: PKMNNetworkingDataSourceProtocol
  
  /// The JSON worker.
  private var jsonWorker: JSONDataSourceProtocol

  /// In this variables are stored the fetched `Pokemon` from the api ``/pokemon/{id}``
  private var fetchedPokemons: [Pokemon] = []
  
  /// In this variables are stored the fetched `PokemonListItem` from the api ``/pokemon``
  private var fetchedPokemonItems: [PokemonListItem] = []
  
  /// In this variables is stored the selected id for a selected `Pokemon`.
  private var selectedID: String = String()

  // MARK: - Init
  
  /// The `init` with the needed workers.
  /// - Parameters:
  ///   - networkingWorker: The networking worker.
  ///   - jsonWorker: The networking worker.
  init(networkingWorker: PKMNNetworkingDataSourceProtocol, jsonWorker: JSONDataSourceProtocol) {
    self.networkingWorker = networkingWorker
    self.jsonWorker = jsonWorker
  }
  
  // MARK: - Mock

  /// Get info about a mocked `Pokemon`
  func getMockedPokemon() async throws -> Pokemon {
    try await jsonWorker.getPokemon()
  }

  /// Get info about a mocked `PokemonList`
  func getMockedPokemonsList() async throws -> PokemonsList {
    try await jsonWorker.pokemonsList()
  }
  
  // MARK: - Async
  
  /// Get info about `Pokemon` by his ID. If it's cached, reuturns it, else retrieves from network.
  func asyncGetPokemon(id: String) async throws -> Pokemon {
    if let pokemon = fetchedPokemons.first(where: { _pokemon in
        _pokemon.id == Int(id)
      }) {
      return pokemon
    }
    
    return try await networkingWorker.getPokemon(id: id)
  }
  
  /// Get info about `PokemonList` from the network.
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
    queryItems == nil ? fetchedPokemonItems.removeAll() : nil
    let pokemonsList = try await networkingWorker.asyncGetPokemonsList(queryItems: queryItems)
    self.fetchedPokemonItems.append(contentsOf: pokemonsList.pokemonItems)
    
    return pokemonsList
  }
  
  /// Get info about `Pokemon`s by their name. If are cached, returns them, else retrieves from network.
  func asyncSearchCachedPokemon(name: String) -> [PokemonListItem] {
    let filteredPokemonListItems = fetchedPokemonItems.filter { pokemonListItem in
      pokemonListItem.name.contains(name)
    }
    let filteredPokemon = fetchedPokemons.filter { pokemon in
      pokemon.name.contains(name)
    }.map { pokemon in
      PokemonListItem(pokemonListItemDataSource: .init(pokemon: pokemon))
    }

    let finalFilteredPokemonItems = (filteredPokemonListItems + filteredPokemon).uniques(by: \.id)
    return finalFilteredPokemonItems
  }
  
  /// Set the id for a selected `Pokemon`.
  func setSelectedID(id: String) {
    selectedID = id
  }
  
  /// Get the id for a selected `Pokemon`.
  func getSelectedID() -> String {
    selectedID
  }
}
