//
//  PKMNDetailAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNDetailAssembler

public class PKMNDetailAssembler: PKMNDetailAssemblerInjector {
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
    return PKMNDetailViewController(viewModel: self.resolve())
  }

  func resolve() -> PKMNDetailViewModel {
    return PKMNDetailViewModel(getPokemonByIDUseCase: container.getPokemonByIDUseCase, id: id)
  }
}
