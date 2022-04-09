//
//  Pokemon.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct Pokemon {
  public let abilities: [Ability]
  public let baseExperience: Int
  public let forms: [Forms]
  public let height: Int
  public let id: Int
  public let name: String
  public let order: Int
  public let species: Species
  public let frontImage: FrontImage
  public let stats: [Stat]
  public let weight: Int

  public init(pokemonDataSource: PokemonDataSource) {
    abilities = pokemonDataSource.abilities.map { _abilities in
      Ability(abilityDataSource: _abilities.ability)
    }
    baseExperience = pokemonDataSource.baseExperience
    forms = pokemonDataSource.forms.map { formDataSource in
      Forms(formsDataSource: formDataSource)
    }
    height = pokemonDataSource.height
    id = pokemonDataSource.id
    name = pokemonDataSource.name
    order = pokemonDataSource.order
    species = Species(speciesDataSource: pokemonDataSource.species)
    frontImage = FrontImage(spritesDataSource: pokemonDataSource.sprites)
    stats = pokemonDataSource.stats.map { statDataSource in
      Stat(statDataSource: statDataSource)
    }
    weight = pokemonDataSource.weight
  }
}
