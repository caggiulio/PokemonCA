//
//  PKMNDetailAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNDetailAssembler

public struct PKMNDetailAssembler: PKMNDetailAssemblerInjector {
  var container: PKMNMainContainerProtocol
  var id: String

  public init(container: PKMNMainContainerProtocol, id: String) {
    self.container = container
    self.id = id
  }
}

// MARK: - PKMNDetailAssemblerInjector

public protocol PKMNDetailAssemblerInjector {
  func resolve() -> PKMNDetailViewController

  func resolve() -> PKMNDetailViewModel
}

public extension PKMNDetailAssembler {
  func resolve() -> PKMNDetailViewController {
    PKMNDetailViewController(viewModel: self.resolve())
  }

  func resolve() -> PKMNDetailViewModel {
    PKMNDetailViewModel(asyncGetPokemonByIDUseCase: container.asyncGetPokemonByIDUseCase, id: id)
  }
}
