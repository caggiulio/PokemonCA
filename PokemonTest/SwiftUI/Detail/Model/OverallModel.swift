//
//  OverallModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 02/12/22.
//

import Foundation

/// The model for the `OverallView`.
struct OverallModel: Identifiable {
  
  // MARK: - Stored Properties
  
  /// The `id` of the `View`.
  var id: UUID = UUID()
  
  /// The title of the `OverallView`.
  let title: String
  
  /// The value of the `OverallView`.
  let value: Float
}
