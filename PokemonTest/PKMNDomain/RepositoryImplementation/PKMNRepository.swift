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

  /// In this variables are stored the retrieved `Pokemon` from the api ``/pokemon/{id}``
  private var pokemonRetrieved: [Pokemon] = []
  
  /// In this variables are stored the retrieved `PokemonListItem` from the api ``/pokemon``
  private var pokemonItemsRetrieved: [PokemonListItem] = []

  // MARK: - Init
  
  /// The `init` with the needed workers.
  /// - Parameters:
  /// - networkingWorker: The networking worker.
  /// - jsonWorker: The networking worker.
  init(networkingWorker: PKMNNetworkingDataSourceProtocol, jsonWorker: JSONDataSourceProtocol) {
    self.networkingWorker = networkingWorker
    self.jsonWorker = jsonWorker
  }
  
  // MARK: - Mock

  /// Get info about a mocked `Pokemon`
  func getMockedPokemon(completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
    jsonWorker.getPokemon { result in
      completion(result)
    }
  }

  /// Get info about a mocked `PokemonList`
  func getMockedPokemonsList(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
    jsonWorker.pokemonsList { result in
      completion(result)
    }
  }
  
  // MARK: - Async
  
  /// Get info about `Pokemon` by his ID. If it's cached, reuturns it, else retrieves from network.
  func asyncGetPokemon(id: String) async throws -> Pokemon {
    if let pokemon = pokemonRetrieved.first(where: { _pokemon in
        _pokemon.id == Int(id)
      }) {
      return pokemon
    }
    
    return try await networkingWorker.getPokemon(id: id)
  }
  
  /// Get info about `PokemonList` from the network.
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
    queryItems == nil ? pokemonItemsRetrieved.removeAll() : nil
    let pokemonsList = try await networkingWorker.asyncGetPokemonsList(queryItems: queryItems)
    self.pokemonItemsRetrieved.append(contentsOf: pokemonsList.pokemonItems)
    
    return pokemonsList
  }
  
  /// Get info about `Pokemon`s by their name. If are cached, returns them, else retrieves from network.
  func asyncSearchCachedPokemon(name: String) -> [PokemonListItem] {
    let filteredPokemonListItems = pokemonItemsRetrieved.filter { pokemonListItem in
      pokemonListItem.name.contains(name)
    }
    let filteredPokemon = pokemonRetrieved.filter { pokemon in
      pokemon.name.contains(name)
    }.map { pokemon in
      PokemonListItem(pokemonListItemDataSource: .init(pokemon: pokemon))
    }

    let finalFilteredPokemonItems = (filteredPokemonListItems + filteredPokemon).uniques(by: \.id)
    return finalFilteredPokemonItems
  }
}
