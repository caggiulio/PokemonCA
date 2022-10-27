//
//  JSONDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The protocol to defines the methods to make mock calls.
public protocol JSONDataSourceProtocol {
  func getPokemon(completion: (Result<Pokemon, PKMNError>) -> Void)
  func pokemonsList(completion: (Result<PokemonsList, PKMNError>) -> Void)
}
