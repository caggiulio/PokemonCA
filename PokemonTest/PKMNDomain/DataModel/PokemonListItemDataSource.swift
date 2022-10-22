//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//
import Foundation

public struct PokemonListItemDataSource: Decodable {
  let name: String
  let url: String

  public init(pokemon: Pokemon) {
    name = pokemon.name
    url = PKMNConstants.baseURL + "pokemon/\(pokemon.id)/"
  }
}
