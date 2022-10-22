//
//  PKMNRepositoryProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocols to defines the methods needed to store and retrieve `Pokemon` and `PokemonListItem`s from the repository.
public protocol PKMNRepositoryProtocol {
  
  // MARK: - Mocked
  
  func getMockedPokemon(completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
  func getMockedPokemonsList(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
  
  // MARK: - Async
  
  func asyncGetPokemon(id: String) async throws -> Pokemon
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList
  func asyncSearchCachedPokemon(name: String) -> [PokemonListItem]
}
