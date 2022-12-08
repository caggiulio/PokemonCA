//
//  AbilityModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 31/10/22.
//

import Foundation

/// The model for the `AbilityView`.
struct AbilityModel: Identifiable {
  
  // MARK: - Stored Properties
  
  /// The `id` of the `View`.
  var id: UUID = UUID()
  
  /// The title of the `Ability`.
  let title: String
  
  /// The value of the `Ability`.
  let value: Float
}
