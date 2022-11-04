//
//  PKMNDetailModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import Foundation

/// This is the model used to fill the detail.
struct PKMNDetailModel: PKMNModel {
  // MARK: - Stored Properties
  
  /// The `Pokemon` used to fill the details.
  let pokemon: Pokemon
  
  // MARK: - Computed Properties
  
  /// The list of the abilities. Build the right `AbilityModel`.
  var abilities: [AbilityModel] {
    pokemon.stats.map { ability in
      AbilityModel(title: ability.name, value: ability.percentStat)
    }
  }
}
