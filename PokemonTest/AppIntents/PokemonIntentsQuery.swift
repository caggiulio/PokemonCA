//
//  PokemonIntentsQuery.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 06/10/22.
//

import AppIntents
import Foundation

/// The `EntityPropertyQuery` of the `PokemonAppEntity`.
@available(iOS 16.0, *)
struct PKMNIntentsQuery: EntityPropertyQuery {
  
  // MARK: - Computed Properties
  
  /// A type that provides the properties to include in a property-matched query.
  static var properties = EntityQueryProperties<PokemonAppEntity, String> {
    Property(\.$name) {
      EqualToComparator { $0 }
      ContainsComparator { $0 }
    }
  }
  
  /// The sorting options provided by the `EntityPropertyQuery` protocol.
  static var sortingOptions = SortingOptions {
    SortableBy(\.$name)
  }
  
  // MARK: - Entities Methods
  
  /// Find an entity by his ID.
  /// For example a user may have chosen a Pokemon from a list when tapping on a parameter that accepts Pokemon. The ID of that Pokemon is now hardcoded into the `Shortcut`.
  /// - Parameter identifiers: The list of IDs for the Pokemons that the user selected.
  /// - Returns: The list of `[PokemonAppEntity]` found.
  func entities(for identifiers: [String]) async throws -> [PokemonAppEntity] {
    let pokemons = try await IntentsLogic.FetchData.Pokemons.execute()
    return pokemons.filter { identifiers.contains($0.id) }
  }
  
  func entities(matching comparators: [String], mode: ComparatorMode, sortedBy: [Sort<PokemonAppEntity>], limit: Int?) async throws -> [PokemonAppEntity] {
    guard !comparators.isEmpty, let name = comparators.first else {
      return try await IntentsLogic.FetchData.Pokemons.execute()
    }
    return try await IntentsLogic.FetchData.PokemonByQuery.execute(query: name)
  }
  
  /// Returns all Pokemon. This is what populates the list when you tap on a parameter that accepts a Pokemon.
  func suggestedEntities() async throws -> [PokemonAppEntity] {
    try await IntentsLogic.FetchData.Pokemons.execute()
  }
}
