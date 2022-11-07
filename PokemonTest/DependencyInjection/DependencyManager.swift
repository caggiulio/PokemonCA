//
//  DependencyManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 07/11/22.
//

import Foundation

/// The class to resolve the dependencies of the app.
class DependencyManager {
  // MARK: - Computed Properties
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  private var assembler: PKMNSwiftUIAssembler {
    PKMNSwiftUIAssembler()
  }
  
  /// The container with all the use-cases of the app.
  private var container: PKMNMainContainer {
    PKMNMainContainer()
  }
  
  /// The networking manager to make API calls. It's a concrete implementation of `PKMNNetworkingManager`.
  private var networkingManager: PKMNNetworkingManager {
    PKMNNetworkingManager()
  }
  
  /// The JSON manager to make mock calls. It's a concrete implementation of `JSONDataSourceManager`.
  private var jsonManager: JSONDataSourceManager {
    JSONDataSourceManager()
  }
    
  // MARK: - Init
  
  /// The init of the app.
  init() {
    addDependencies()
  }
    
  // MARK: - Private Methods
  
  /// This method add the depencies to shared `Resolver` instance.
  private func addDependencies() {
    let resolver = Resolver.shared
    resolver.add(networkingManager)
    resolver.add(jsonManager)
    resolver.add(container)
    resolver.add(assembler)
  }
}
