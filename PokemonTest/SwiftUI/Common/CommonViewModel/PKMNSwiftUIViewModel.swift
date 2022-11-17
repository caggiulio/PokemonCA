//
//  PKMNSwiftUIViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import Combine
import SwiftUI

open class PKMNSwiftUIViewModel<Model: PKMNModel>: ObservableObject, CoordinatorFlowStateProtocol {
  // MARK: - Computed Properties
  
  /// The loading state with his related `Model`.
  @Published var loadingState: LoadingState<Model, PKMNError> = .idle
  
  /// The last value of the `Model` if exist. This variable is assigned when a `LoadingState`
  /// become `.success`.
  @Published var lastValueModel: Model?
  
  /// The `CoordinatorLink` used to determine the navigation. When is set, the `View` will try to navigate.
  @Published var activeLink: CoordinatorLink?
  
  /// The cancellables set used for store `Combine` values.
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Init
  
  /// At the `init` observes the `loadingState` value in order to update always the `lastValueModel`.
  init() {    
    self.$loadingState.sink { [weak self] state in
      guard let newValue = state.value else {
        return
      }
      self?.lastValueModel = newValue
    }
    .store(in: &cancellables)    
  }
  
  // MARK: - Methods
    
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
