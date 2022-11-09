//
//  DependencyManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 07/11/22.
//

import Foundation

/// The class to resolve the dependencies of the app.
class DependencyManager {
  // MARK: - Stored Properties
  
  /// The responsible manager to add the depencies of the app architecture.
  private var architectureDepenciesManager: ArchitectureDependencyManager
  
  /// The responsible manager to add the depencies of the UseCases of the app .
  private var useCasesDepenciesManager: UseCaseDepencyManager
  
  // MARK: - Init
  
  /// The init of the manager.
  init() {
    architectureDepenciesManager = ArchitectureDependencyManager()
    useCasesDepenciesManager = UseCaseDepencyManager()
  }
}
