//
//  PKMNSwiftUIViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import Foundation
import SwiftUI

open class PKMNSwiftUIViewModel<Model: PKMNModel>: ObservableObject {
  /// The loading state with his related `Model`.
  @Published var loadingState: LoadingState<Model, PKMNError> = .idle
    
  /// The func to process a `Task` that throw an error or a `Model`.
  /// If there is an error, the `loadingState` will be `failure` with a `PKMNError`.
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
