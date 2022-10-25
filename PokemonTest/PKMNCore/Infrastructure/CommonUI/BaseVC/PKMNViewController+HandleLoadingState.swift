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
      self.rootView.showLoader()
    case let .success(value):
      self.rootView.hideLoader()
      success?(value)
    case let .failure(error):
      self.rootView.hideLoader()
      failure?(error)
    }
  }
  
  func handle<Value: PKMNModel, PKMNError>(_ loadingState: LoadingState<Value, PKMNError>) {
    self.handlePKMNState(state: loadingState, success: { [weak self] value in
      guard let value = value as? Model else {
        return
      }
      self?.rootView.model = value
    }, failure: { [weak self] error in
      self?.errorHandler?.throw(error)
    })
  }
}
