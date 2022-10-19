//
//  PKMNViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 09/04/22.
//

import Foundation

open class PKMNViewModel<Model: PKMNModel>: NSObject {
  public var updateStatus: ((LoadingState<Model, PKMNError>) -> Void)?
  
  /// The loading state updates the closure `updateStatus`
  public var loadingState: LoadingState<Model, PKMNError> = .idle {
    didSet {
      updateStatus?(loadingState)
    }
  }
  
  @MainActor
  func processTask(function: () async throws -> Model) async rethrows {
    loadingState = .loading(true)
    
    do {
      let successModel = try await function()
      self.loadingState = .success(successModel)
    } catch let error {
      guard let error = error as? PKMNError else {
        return
      }
      self.loadingState = .failure(error)
    }
  }
}
