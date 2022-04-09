//
//  PKMNRepositoryProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol PKMNRepositoryProtocol {
  func getPokemon(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
  func getPokemonsList(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
  func searchCachedPokemon(name: String, completion: @escaping (Result<[PokemonListItem], PKMNError>) -> Void)

  func getMockedPokemon(completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
  func getMockedPokemonsList(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}
