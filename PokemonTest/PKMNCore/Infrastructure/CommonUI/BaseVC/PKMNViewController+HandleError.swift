//
//  PKMNViewController+HandleError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public extension PKMNViewController {
  func handleError(error: PKMNError) {
    switch error {
      default:
        showToast(color: .systemRed, text: error.localizedDescription, completion: nil)
    }
  }
}
