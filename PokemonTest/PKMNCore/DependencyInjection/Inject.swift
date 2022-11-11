//
//  Inject.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 07/11/22.
//

import Foundation

/// The `Injectable` protocol.
protocol Injectable {}

@propertyWrapper
/// The `Inject` property wrapper.
struct Injected<T: Injectable> {
  // MARK: - Stored properties
  
  /// The generic `Injectable`.
  let wrappedValue: T
  
  // MARK: - Init
  
  /// The init of the `Inject` property wrapper.
  init() {
    wrappedValue = Resolver.shared.resolve()
  }
}
