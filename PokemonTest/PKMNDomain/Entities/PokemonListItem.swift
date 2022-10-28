//
//  PokemonListItem.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct PokemonListItem: PKMNModel, Identifiable, Equatable {
  let pokemonListItemDataSource: PokemonListItemDataSource

  var name: String {
    return pokemonListItemDataSource.name
  }

  var imageURL: String {
    let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%@.png"
    return String(format: baseUrl, getID(pokemonListItemDataSource: pokemonListItemDataSource))
  }

  public var id: String {
    return getID(pokemonListItemDataSource: pokemonListItemDataSource)
  }

  var ranking: String {
    return getID(pokemonListItemDataSource: pokemonListItemDataSource)
  }

  public init(pokemonListItemDataSource: PokemonListItemDataSource) {
    self.pokemonListItemDataSource = pokemonListItemDataSource
  }

  private func getID(pokemonListItemDataSource: PokemonListItemDataSource) -> String {
    let components = pokemonListItemDataSource.url.components(separatedBy: "/")
    return components[components.count - 2]
  }
}

extension PokemonListItem {
  public static func == (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
    lhs.id == rhs.id
  }
}
