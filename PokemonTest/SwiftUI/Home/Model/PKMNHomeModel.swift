//
//  PKMNHomeModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 29/10/22.
//

import Foundation

/// This is the model used to fill the home.
struct PKMNHomeModel: PKMNModel {
  // MARK: - Stored Properties
  
  /// The title of the view.
  var title = PKMNString.homeTitle
  
  /// The list of Pokemon to show.
  let pokemonList: [PokemonListItem]
  
  /// The filtered list of Pokemon to show.
  let filteredPokemonList: [PokemonListItem]
  
  // MARK: - Computed Properties
  
  /// Wheter the list is filtered or not.
  var isFiltered: Bool {
    !filteredPokemonList.isEmpty
  }
  
  /// The model for the `PKMNSwiftUIHomeBody`.
  var bodyModel: PKMNHomeBodyModel {
    PKMNHomeBodyModel(
      title: title,
      isFiltered: isFiltered,
      pokemonList: pokemonList,
      filteredPokemonList: filteredPokemonList
    )
  }
}
