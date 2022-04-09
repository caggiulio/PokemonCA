//
//  PKMNError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNError

public enum PKMNError: Swift.Error, Equatable {
  case genericError(String)
  case resourceNotFound
}

// MARK: LocalizedError

extension PKMNError: LocalizedError {
  /// We must override `errorDescription` to access `error.localizedDescription`

  public var errorDescription: String? {
    switch self {
      case let .genericError(message):
        return message
      case .resourceNotFound:
        return PKMNString.resourceNotFound
    }
  }
}
