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

  private enum CodingKeys: String, CodingKey {
    case name
    case url
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    url = try values.decode(String.self, forKey: .url)
  }

  public init(pokemon: Pokemon) {
    name = pokemon.name
    url = PKMNConstants.baseURL + "pokemon/\(pokemon.id)/"
  }
}
