//
//  PKMNErrorManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

class PKMNErrorManager {
  static func parsePKMNError(response: URLResponse) -> PKMNError {
    let pkmnError = PKMNErrorManager.decodePKMNError(response: response)
    return pkmnError
  }

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
