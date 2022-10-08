//
//  PKMNViewController+HandleLoadingState.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 09/04/22.
//

import Foundation

public extension PKMNViewController {
  func handlePKMNState<Value: Any, PKMNError>(state: LoadingState<Value, PKMNError>, success: ((Value) -> Void)? = nil, failure: ((PKMNError) -> Void)? = { _ in }, throwBaseError: Bool = true) {
    switch state {
    case .idle:
      break
    case .loading:
      self._view.showLoader()
    case let .success(value):
      self._view.hideLoader()
      success?(value)
    case let .failure(error):
      self._view.hideLoader()
      errorHandler?.throw(error)
    }
  }
  
  func handle<Value: Any, PKMNError>(_ loadingState: LoadingState<Value, PKMNError>) {
    self.handlePKMNState(state: loadingState, success: { value in
      self._view.model = value
    }, failure: { _ in })
  }
}
