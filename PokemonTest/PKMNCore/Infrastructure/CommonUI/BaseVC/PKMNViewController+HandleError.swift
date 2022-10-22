//
//  PKMNViewController+HandleError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public extension PKMNViewController {
  func handleError() {
    /// Initialization of `errorHandler`
    errorHandler = PKMNMainErrorManager().listen(PKMNError.self, action: { [weak self] error in
      switch error {
      default:
        self?.showToast(color: .systemRed, text: error.localizedDescription, completion: nil)
      }
    })
  }
}
