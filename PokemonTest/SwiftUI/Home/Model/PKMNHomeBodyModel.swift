//
//  PKMNHomeBodyModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 02/11/22.
//

import Foundation

/// The model for the `PKMNSwiftUIHomeBody`.
struct PKMNHomeBodyModel {
  /// The title of the `View`.
  let title: String
  
  /// Wheter the list is filtered or not.
  let isFiltered: Bool
  
  /// The standard `Pokemon` list.
  let pokemonList: [PokemonListItem]
  
  /// The filtered `Pokemon` list.
  let filteredPokemonList: [PokemonListItem]
  
  /// The user taps on the
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameters:
  ///   - title: the title of the `View`.
  ///   - isFiltered: wheter the list is filtered or not.
  ///   - pokemonList: the standard `Pokemon` list.
  ///   - filteredPokemonList: the filtered `Pokemon` list.
  init(title: String, isFiltered: Bool, pokemonList: [PokemonListItem], filteredPokemonList: [PokemonListItem]) {
    self.title = title
    self.isFiltered = isFiltered
    self.pokemonList = pokemonList
    self.filteredPokemonList = filteredPokemonList
  }
}
