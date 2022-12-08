//
//  PKMNViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 09/04/22.
//

import Foundation

open class PKMNViewModel<Model: PKMNModel>: NSObject {
  /// The loading state that updates the closure `updateStatus`.
  @Published var loadingState: LoadingState<Model, PKMNError> = .idle
  
  /// The func to process a `Task` that throw an error or a `Model`.
  /// If there is an error, the `loadingState` will be `failure` with a `PKMNError`.
  @MainActor
  func process(function: () async throws -> Model) async rethrows {
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
