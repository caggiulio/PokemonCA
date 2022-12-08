//
//  PKMNUseCases.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

enum PKMNUseCases {
  
  // MARK: - Mock Methods Implementation

  /// Get mocked info Pokemon.
  struct GetMockedPokemon: GetMockedPokemonProtocol {
    @Injected private var pokemonRepository: PKMNRepository

    func execute() async throws -> Pokemon {
      try await pokemonRepository.getMockedPokemon()
    }
  }

  /// Get mocked info PokemonList .
  struct GetMockedPokemonsList: GetMockedPokemonsListProtocol {
    @Injected private var pokemonRepository: PKMNRepository

    func execute() async throws -> PokemonsList {
      try await pokemonRepository.getMockedPokemonsList()
    }
  }
  
  // MARK: -  Methods Implementation
  
  /// Get real info Pokemon by his id in `async` way.
  struct GetPokemonByID: GetPokemonByIDProtocol {
    @Injected private var pokemonRepository: PKMNRepository
    
    func execute() async throws -> Pokemon {
      let id = pokemonRepository.getSelectedID()
      return try await pokemonRepository.asyncGetPokemon(id: id)
    }
  }
  
  /// Get real  info PokemonList in `async` way.
  struct GetPokemonsList: GetPokemonsListProtocol {
    @Injected private var pokemonRepository: PKMNRepository

    func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
      try await pokemonRepository.asyncGetPokemonsList(queryItems: queryItems)
    }
  }
  
  /// Get real info PokemonList by his name in `async` way.
  struct SearchPokemonByName: SearchPokemonByNameProtocol {
    @Injected private var pokemonRepository: PKMNRepository

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
    @Injected private var pokemonRepository: PKMNRepository
    
    func execute(id: String) {
      pokemonRepository.setSelectedID(id: id)
    }
  }
  
  /// Get the id for a selected `Pokemon`.
  struct GetSelectedPokemonID: GetSelectedPokemonIDProtocol {
    @Injected private var pokemonRepository: PKMNRepository
    
    func execute() -> String {
      pokemonRepository.getSelectedID()
    }
  }
  
  /// Get the overall for the selected `Pokemon`.
  struct GetPokemonOverall: GetOverallProtocol {
    @Injected private var pokemonRepository: PKMNRepository
    
    func execute() async throws -> Float {
      let id = pokemonRepository.getSelectedID()
      let pokemon = try await pokemonRepository.asyncGetPokemon(id: id)
      let totalValue = pokemon.stats.reduce(into: 0) { partial, stat in
        partial += stat.baseStat
      }
      return Float(totalValue / pokemon.stats.count) / 100
    }
  }
  
  /// Get the current weather condition for the current location.
  struct GetCurrentWeather: GetCurrentWeatherProtocol {
    @Injected private var weatherRepository: PKMNWeatherRepository
    
    func execute() async throws -> CurrentWeather {
      try await weatherRepository.getCurrentWeather()
    }
  }
}
