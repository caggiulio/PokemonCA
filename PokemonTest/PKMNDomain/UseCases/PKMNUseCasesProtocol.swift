//
//  PKMNUseCasesProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 21/10/22.
//

import Foundation

// MARK: - Mock Methods

/// Get mocked info Pokemon.
public protocol GetMockedPokemonProtocol {
  func execute(completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
}

/// Get mocked info PokemonList.
public protocol GetMockedPokemonsListProtocol {
  func execute(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}


// MARK: - Async Methods

/// Get mocked info PokemonList.
public protocol AsyncGetPokemonByIDProtocol {
  func execute(id: String) async throws -> Pokemon
}

/// Get mocked info PokemonList.
public protocol AsyncGetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}

/// Get real info PokemonList by his name in `async` way.
public protocol AsyncSearchPokemonByNameProtocol {
  func execute(name: String) async throws -> [PokemonListItem]
}
