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
}

public struct PKViewModel<Model: PKMNModel> {
  public var updateStatus: ((LoadingState<Model, PKMNError>) -> Void)?
  
  /// The loading state updates the closure `updateStatus`
  public var loadingState: LoadingState<Model, PKMNError> = .idle {
    didSet {
      updateStatus?(loadingState)
    }
  }
}
