//
//  PKMNRepositoryProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocols to defines the methods needed to store and retrieve `Pokemon` and `PokemonListItem`s from the repository.
protocol PKMNRepositoryProtocol {
  
  // MARK: - Mocked
  
  func getMockedPokemon() async throws -> Pokemon
  func getMockedPokemonsList() async throws -> PokemonsList
  
  // MARK: - 
  
  func asyncGetPokemon(id: String) async throws -> Pokemon
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList
  func asyncSearchCachedPokemon(name: String) -> [PokemonListItem]
}
