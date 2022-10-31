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
  struct GetMockedPokemon: GetMockedPokemonProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    func execute() async throws -> Pokemon {
      try await pokemonRepository.getMockedPokemon()
    }
  }

  /// Get mocked info PokemonList .
  struct GetMockedPokemonsList: GetMockedPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    func execute() async throws -> PokemonsList {
      try await pokemonRepository.getMockedPokemonsList()
    }
  }
  
  // MARK: - Async Methods Implementation
  
  /// Get real info Pokemon by his id in `async` way.
  struct AsyncGetPokemonByID: AsyncGetPokemonByIDProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    func execute(id: String) async throws -> Pokemon {
      try await pokemonRepository.asyncGetPokemon(id: id)
    }
  }
  
  /// Get real  info PokemonList in `async` way.
  struct AsyncGetPokemonsList: AsyncGetPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
      try await pokemonRepository.asyncGetPokemonsList(queryItems: queryItems)
    }
  }
  
  /// Get real info PokemonList by his name in `async` way.
  struct AsyncSearchPokemonByName: AsyncSearchPokemonByNameProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    init(pokemonRepository: PKMNRepositoryProtocol) {
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

    func execute(name: String) async throws -> [PokemonListItem] {
      try await getCachedPokemonsByName(name: name.lowercased())
    }
  }
}
