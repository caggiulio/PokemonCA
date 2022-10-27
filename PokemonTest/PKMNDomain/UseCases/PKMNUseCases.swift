//
//  PKMNUseCases.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - Closures UseCases Implementation

enum PKMNUseCases {
  
  // MARK: - Mock Methods Implementation

  /// Get mocked info Pokemon.
  public struct GetMockedPokemon: GetMockedPokemonProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
      pokemonRepository.getMockedPokemon { result in
        completion(result)
      }
    }
  }

  /// Get mocked info PokemonList .
  public struct GetMockedPokemonsList: GetMockedPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
      pokemonRepository.getMockedPokemonsList { result in
        completion(result)
      }
    }
  }
  
  // MARK: - Async Methods Implementation
  
  /// Get real info Pokemon by his id in `async` way.
  public struct AsyncGetPokemonByID: AsyncGetPokemonByIDProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(id: String) async throws -> Pokemon {
      try await pokemonRepository.asyncGetPokemon(id: id)
    }
  }
  
  /// Get real  info PokemonList in `async` way.
  public struct AsyncGetPokemonsList: AsyncGetPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
      try await pokemonRepository.asyncGetPokemonsList(queryItems: queryItems)
    }
  }
  
  /// Get real info PokemonList by his name in `async` way.
  public struct AsyncSearchPokemonByName: AsyncSearchPokemonByNameProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    private func getCachedPokemonsByName(name: String) async throws -> [PokemonListItem] {
      let pokemons = pokemonRepository.asyncSearchCachedPokemon(name: name)
      if pokemons.isEmpty {
        let pokemon = try await self.pokemonRepository.asyncGetPokemon(id: name)
        let uniquePokemon = [PokemonListItem(pokemonListItemDataSource: .init(pokemon: pokemon))]
        return uniquePokemon
      } else {
        return pokemons
      }
    }

    public func execute(name: String) async throws -> [PokemonListItem] {
      try await getCachedPokemonsByName(name: name.lowercased())
    }
  }
}
