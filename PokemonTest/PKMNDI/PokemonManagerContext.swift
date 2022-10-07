//
//  PokemonManagerContext.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 06/10/22.
//

import Foundation

/// The struct with the main container, that will be the context of the app.
struct PokemonManagerContext {
  /// The singleton instance of `PokemonManagerContext`.
  static let shared = PokemonManagerContext()
  
  /// The main container of the app.
  let container: PKMNMainContainer
  
  // MARK: - Init
  
  init() {
    container = PKMNMainContainer()
  }
}
