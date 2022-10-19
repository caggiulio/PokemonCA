//
//  PKMNNetworkingDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocol to defines the list of API calls to implements.
public protocol PKMNNetworkingDataSourceProtocol {
  
  // MARK: - Closures
  
  func getPokemon(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
  func pokemonsList(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
  
  // MARK: - Async
  
  func getPokemon(id: String) async throws -> Pokemon
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}
