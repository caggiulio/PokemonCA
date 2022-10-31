//
//  PKMNUseCasesProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 21/10/22.
//

import Foundation

// MARK: - Mock Methods

/// Get mocked info Pokemon.
protocol GetMockedPokemonProtocol {
  func execute() async throws -> Pokemon
}

/// Get mocked info PokemonList.
protocol GetMockedPokemonsListProtocol {
  func execute() async throws -> PokemonsList
}


// MARK: - Async Methods

/// Get mocked info PokemonList.
protocol AsyncGetPokemonByIDProtocol {
  func execute(id: String) async throws -> Pokemon
}

/// Get mocked info PokemonList.
protocol AsyncGetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}

/// Get real info PokemonList by his name in `async` way.
protocol AsyncSearchPokemonByNameProtocol {
  func execute(name: String) async throws -> [PokemonListItem]
}
