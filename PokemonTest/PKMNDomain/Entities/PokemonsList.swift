//
//  PokemonsList.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct PokemonsList {
  let count: Int
  let next: String
  let pokemonItems: [PokemonListItem]

  public init(pokemonsListDataSource: PokemonListDataSource) {
    count = pokemonsListDataSource.count
    next = pokemonsListDataSource.next
    pokemonItems = pokemonsListDataSource.results.map { _pokemonListItemsDataSource in
      PokemonListItem(pokemonListItemDataSource: _pokemonListItemsDataSource)
    }
  }
}
