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
        self.abilities = pokemonDataSource.abilities.map({ _abilities in
            return Ability(abilityDataSource: _abilities.ability)
        })
        self.baseExperience = pokemonDataSource.baseExperience
        self.forms = pokemonDataSource.forms.map({ formDataSource in
            return Forms(formsDataSource: formDataSource)
        })
        self.height = pokemonDataSource.height
        self.id = pokemonDataSource.id
        self.name = pokemonDataSource.name
        self.order = pokemonDataSource.order
        self.species = Species(speciesDataSource: pokemonDataSource.species)
        self.frontImage = FrontImage(spritesDataSource: pokemonDataSource.sprites)
        self.stats = pokemonDataSource.stats.map({ statDataSource in
            return Stat(statDataSource: statDataSource)
        })
        self.weight = pokemonDataSource.weight
    }
    
}
