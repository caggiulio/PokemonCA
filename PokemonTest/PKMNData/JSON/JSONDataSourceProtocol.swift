//
//  JSONDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocol to defines the methods to make mock calls.
protocol JSONDataSourceProtocol {
  func getPokemon() async throws -> Pokemon
  func pokemonsList() async throws -> PokemonsList
}
