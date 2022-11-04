//
//  PKMNError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNError

/// The custom `Swift.Error` of the app.
enum PKMNError: Swift.Error, Equatable {
  case genericError(String)
  case resourceNotFound
}

// MARK: LocalizedError

extension PKMNError: LocalizedError {
  /// The error description of the `Swift.Error`.
  /// We must override `errorDescription` to access `error.localizedDescription`
  var errorDescription: String? {
    switch self {
      case let .genericError(message):
        return message
      case .resourceNotFound:
        return PKMNString.resourceNotFound
    }
  }
}
