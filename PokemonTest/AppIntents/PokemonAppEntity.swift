//
//  PokemonAppEntity.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 06/10/22.
//

import AppIntents
import Foundation

/// This is the model used with `AppIntents` framework.
@available(iOS 16.0, *)
struct PokemonAppEntity: AppEntity, Identifiable {
  
  /// The `TypeDisplayRepresentation` of the entity.
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Pokemon")
  
  /// The needed `defaultQuery` in order to conform `PokemonAppEntity` to `AppEntity`.
  static var defaultQuery: PKMNIntentsQuery = PKMNIntentsQuery()
  
  /// The unique `String` used to identify the entity.
  var id: String
  
  /// The `@Property` for the name.
  @Property(title: "Name")
  var name: String
  
  /// The `DisplayRepresentation` type planned by the `AppEntity`.
  /// A type that describes the user interface presentation of a custom type.
  var displayRepresentation: DisplayRepresentation {
    return DisplayRepresentation(
      title: "\(name)",
      subtitle: nil,
      image: .init(data: AppAsset.pokeball.image.pngData() ?? Data())
    )
  }
  
  // MARK: - Init
  
  init(id: String, name: String) {
    self.id = id
    self.name = name
  }
}

// MARK: - Extensions

@available(iOS 16.0, *)
extension PokemonAppEntity: Equatable {
  static func == (lhs: PokemonAppEntity, rhs: PokemonAppEntity) -> Bool {
    return lhs.id == rhs.id
  }
}

@available(iOS 16.0, *)
extension PokemonAppEntity: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
