//
//  PKMNNetworkingDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocol to defines the list of API calls to implements.
public protocol PKMNNetworkingDataSourceProtocol {
  
  // MARK: - Async
  
  func getPokemon(id: String) async throws -> Pokemon
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}
