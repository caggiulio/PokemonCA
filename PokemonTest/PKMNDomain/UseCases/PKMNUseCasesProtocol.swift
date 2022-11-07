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


// MARK: -  Methods

/// Get mocked info PokemonList.
protocol GetPokemonByIDProtocol {
  func execute(id: String) async throws -> Pokemon
}

/// Get mocked info PokemonList.
protocol GetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}

/// Get real info PokemonList by his name in `async` way.
protocol SearchPokemonByNameProtocol {
  func execute(name: String) async throws -> [PokemonListItem]
}
