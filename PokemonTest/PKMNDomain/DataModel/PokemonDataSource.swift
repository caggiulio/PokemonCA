//
//  PokemonDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct PokemonDataSource: Decodable {
  let abilities: [AbilitiesDataSource]
  let baseExperience: Int
  let forms: [FormsDataSource]
  let height: Int
  let id: Int
  let name: String
  let order: Int
  let species: SpeciesDataSource
  let sprites: SpritesDataSource
  let stats: [StatsDataSource]
  let weight: Int

  private enum CodingKeys: String, CodingKey {
    case abilities
    case baseExperience = "base_experience"
    case forms
    case height
    case id
    case isDefault = "is_default"
    case name
    case order
    case species
    case sprites
    case stats
    case weight
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    abilities = try values.decode([AbilitiesDataSource].self, forKey: .abilities)
    baseExperience = try values.decode(Int.self, forKey: .baseExperience)
    forms = try values.decode([FormsDataSource].self, forKey: .forms)
    height = try values.decode(Int.self, forKey: .height)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    order = try values.decode(Int.self, forKey: .order)
    species = try values.decode(SpeciesDataSource.self, forKey: .species)
    sprites = try values.decode(SpritesDataSource.self, forKey: .sprites)
    stats = try values.decode([StatsDataSource].self, forKey: .stats)
    weight = try values.decode(Int.self, forKey: .weight)
  }
}
