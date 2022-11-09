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
    @Inject private var pokemonRepository: PKMNRepository

    func execute() async throws -> Pokemon {
      try await pokemonRepository.getMockedPokemon()
    }
  }

  /// Get mocked info PokemonList .
  struct GetMockedPokemonsList: GetMockedPokemonsListProtocol {
    @Inject private var pokemonRepository: PKMNRepository

    func execute() async throws -> PokemonsList {
      try await pokemonRepository.getMockedPokemonsList()
    }
  }
  
  // MARK: -  Methods Implementation
  
  /// Get real info Pokemon by his id in `async` way.
  struct GetPokemonByID: GetPokemonByIDProtocol {
    @Inject private var pokemonRepository: PKMNRepository
    
    func execute() async throws -> Pokemon {
      let id = pokemonRepository.getSelectedID()
      return try await pokemonRepository.asyncGetPokemon(id: id)
    }
  }
  
  /// Get real  info PokemonList in `async` way.
  struct GetPokemonsList: GetPokemonsListProtocol {
    @Inject private var pokemonRepository: PKMNRepository

    func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
      try await pokemonRepository.asyncGetPokemonsList(queryItems: queryItems)
    }
  }
  
  /// Get real info PokemonList by his name in `async` way.
  struct SearchPokemonByName: SearchPokemonByNameProtocol {
    @Inject private var pokemonRepository: PKMNRepository

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
  
  /// Set the id for a selected `Pokemon`.
  struct SetSelectedPokemonID: SetSelectedPokemonIDProtocol {
    @Inject private var pokemonRepository: PKMNRepository
    
    func execute(id: String) {
      pokemonRepository.setSelectedID(id: id)
    }
  }
  
  /// Get the id for a selected `Pokemon`.
  struct GetSelectedPokemonID: GetSelectedPokemonIDProtocol {
    @Inject private var pokemonRepository: PKMNRepository
    
    func execute() -> String {
      pokemonRepository.getSelectedID()
    }
  }
}
