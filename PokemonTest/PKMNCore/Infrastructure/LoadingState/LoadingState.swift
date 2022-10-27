//
//  LoadingState.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - LoadingState

/// This is the `enum` used to defines the state of the `async` method in the `ViewModel` of the app.
public enum LoadingState<Value, Error: Swift.Error> {
  case idle
  /// The `Bool` indicates if is the first loading or a loading for pagination
  case loading(Bool)
  case success(Value)
  case failure(Error)
}

public extension LoadingState {
  var value: Value? {
    guard case let .success(value) = self else { return nil }
    return value
  }
}
