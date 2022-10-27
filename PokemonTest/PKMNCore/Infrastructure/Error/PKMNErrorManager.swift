//
//  PKMNErrorManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

class PKMNErrorManager {
  /// Decode the error from the network and return it.
  static func parsePKMNError(response: URLResponse) -> PKMNError {
    PKMNErrorManager.decodePKMNError(response: response)
  }

  /// Try to decode the error from the `HTTPURLResponse` and return the right error.
  private static func decodePKMNError(response: URLResponse) -> PKMNError {
    if let httpResponse = response as? HTTPURLResponse {
      switch httpResponse.statusCode {
        case 404:
          return PKMNError.resourceNotFound

        default:
          return PKMNError.genericError(httpResponse.description)
      }
    }

    return PKMNError.genericError(response.description)
  }
}
