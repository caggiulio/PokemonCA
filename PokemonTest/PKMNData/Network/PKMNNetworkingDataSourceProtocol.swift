//
//  PKMNNetworkingDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocol to defines the list of API calls to implements.
protocol PKMNNetworkingDataSourceProtocol {
  
  // MARK: - 
  
  func getPokemon(id: String) async throws -> Pokemon
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}
