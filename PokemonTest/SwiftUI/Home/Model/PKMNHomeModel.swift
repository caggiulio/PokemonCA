//
//  PKMNHomeModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 29/10/22.
//

import Foundation

/// This is the model used to fill the home.
public struct PKMNHomeModel: PKMNModel {
  /// The title of the view.
  let title = PKMNString.homeTitle
  
  /// The list of Pokemon to show.
  let pokemonList: [PokemonListItem]
}
